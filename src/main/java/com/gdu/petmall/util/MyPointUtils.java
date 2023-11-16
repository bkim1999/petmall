package com.gdu.petmall.util;

import org.springframework.stereotype.Component;

import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Data
@Component
public class MyPointUtils {

	/* 만약 다 표시하려면 DB에 저장할 칼럼필요. 필요할때 추가하기*/
	
	private int usedPoint;// 총 사용된 적립금
	private int addPoint;//받은 적립금
	private int point;//사용가능한 적립금
	private int subPoint;//차감될 적립금
	private int totalPoint;//총 적립금
	
	public void setPoint(int addPoint,int subPoint )
	{
		// 포인트 증감 정보
		this.addPoint=addPoint;
		this.subPoint=subPoint;
		
		this.addPoint=addPoint;
		
		//지금까지 받았던 총 적립금
		totalPoint+=addPoint;
		
		//사용가능한 적립금	
							//**사용가능한 포인트보다 소모되는 포인트가 더 크다면 처리할것
		if(point<subPoint)
		{
			
							//**포인트를 전부 사용하고 물건의 가격을 차감하는 식 작성해야함, 일단 현재 포인트를 0으로만 만듦.
			point=0;
		}
		else {
			point+=(addPoint-subPoint);
		}
		
		//사용된 적립금
		usedPoint+=subPoint;
		
	}
	
	
}

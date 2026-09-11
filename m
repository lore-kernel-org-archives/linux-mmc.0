Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C0D45C6E0
	for <linux-mmc@vger.kernel.org>; Fri, 11 Sep 2026 13:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789133701; cv=none; b=EvocQWHXMHrrPJuaU1RAtzKse6v9F9gEG8pbpE9LgNoT8Z4UF8oyHf7wOuB3FCfSeSyQzlRhvSeIyRM2nTYnAbIcfi/K1xpP5Qh5ZwiN2lT5nH+/o+xix9hssLXmNFnSXPPdwDe41I4coMEzUhfq4lcWkjkvWiCy8dDEk1kr7zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789133701; c=relaxed/simple;
	bh=ztJJ8z71GuGpNXypLWHAaVbZFrb5gvtjilMWS/62OAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M5shFHIhxT05+y/mvt0enF048zan5zYyzafx4hUymakHaQRO+bnLc7ShLv9a7ELHkuZIBtA1LOIhUp7alqgBBc5vUnxt0vhnH6BhUtrmYoIpg1OtAWMlx1g+n1f7IYPvRLboNdm/VRPLqF3Ca8+IlxvLK82L4OWH0vqFatwm6+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=b0CwuEQa; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BVnvDLYm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="b0CwuEQa";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BVnvDLYm"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68BCiSBo815021
	for <linux-mmc@vger.kernel.org>; Fri, 11 Sep 2026 13:34:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=rlEXIvgwRQfsHm7KtaBqwgRU
	nTtOOLNR+RQID0qlb+M=; b=b0CwuEQajB0dD0vX5AVMIENVbCA04WAMWp6Ve3DN
	mU7LG8QkJwsaoWqw/CYM1oZB2Gx9WmVEREenY6m2Vmj6k7zgncjYUlvySfSTOcMW
	IDBoDRpvRiQzlXfGzFRY6mOt9G1iskCzeSdB7jM/+8grbyro7PTkhqH1HX8Aokpb
	zN+BpOeSqbP//15I4BhRtJzawY5/g+MOzN4OyfDe/+lOp9QfCGmG7ZgJ0EYle1x6
	4T22vFumxhDUtENHdyltU9Ows0jj+PKlSdhuHq3E8UtcEwQ8DYTWU+zBdwb0H1+k
	gzn9G/RUG6st67G8U1A4yOXVr55ABerkEpClh95aJanvRg==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmbd39ynq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 11 Sep 2026 13:34:59 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5c58ce17b04so952106e0c.0
        for <linux-mmc@vger.kernel.org>; Fri, 11 Sep 2026 06:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789133698; x=1789738498; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rlEXIvgwRQfsHm7KtaBqwgRUnTtOOLNR+RQID0qlb+M=;
        b=BVnvDLYmgeGrkohMSZejL0oa72qZVl/i9e6XYg355k1iLBQKBDvluBrsr55maKCw5q
         IKrO3C92R8B8gPl9LVYRElrmb9K5cejYqT5isPRVPeahIJUoztVIHU+c+W8iQgVsdpNO
         3nVdJLsnToztVjmBy4nCChaUMi5JZ6DUZI40d7UTXjDBplt++jVwpw2Rzozdjbdtw22n
         j0l/KITjUc66OhBvXOLeJo+xk2bvAo5nojDNkcrHnqVmBwTnCzbHy/08x2F2ryOsfHxi
         VfnWVH9Gclc5pkbrfHUY0yKDKPdZ/nsiPgDYxXIsiKSKfmPmmknhEf30gwHDKg59rZtL
         fQvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789133698; x=1789738498;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rlEXIvgwRQfsHm7KtaBqwgRUnTtOOLNR+RQID0qlb+M=;
        b=Vdqh8iSnU5qEZidpR5jmlB+SiAH5b2t6FZ6zcZZJgf6Oam1vTGYFTrl5FAl2d0+Jtf
         0ANl2j0AH8b6WFSGdDiTFZ7RyEFKgUkHMFS1XLdg3uWg2hpdQlT/yPCd54siUB8b7kBh
         MZM+QdyxTn+cIBELv2qG8rnlAX6kytJN5OVOgMFgMPWj2zy6EpiIWsBj0xd22tII9pJh
         AsX/c5C2RrHjZ+sExLs9O8qsRoomvOaQOQp0ipaMsL1GJRlnr3gmVqXNrHjiPgWbdqKF
         Zau/s1iUtsyd59TVnhxGqkXcwe975k3bYwqbTzNZ7pszbI/Io5H1xhJLb9Pk4syvlY3g
         vIQw==
X-Forwarded-Encrypted: i=1; AKwUvBzubum+9OWxheXMEVGIWL+Torv6d5gX/RUKCwUWWpSFEDLkFzD1YK1MZ/ZGUASIg28+Ff/O8jlEGW8=@vger.kernel.org
X-Gm-Message-State: AFuF++nngYS5DY3lrizXDdl+EtedAcHiRix3RRzdT+obsTmOvnUn0Z1K
	fbiyKHR/XycSvldxlR5nAZy3KRSrSy/nbu7OkGpvAlOC0TKuS38tjmFivmg9nDDL1jb5hNp0nHe
	c5v21mCGc8zE/HxQqFZypONXOOo+0wiHzIbGGgEJq/PA5a8zKub7ReMdkG8cyyzXTFhvz1oI=
X-Gm-Gg: AYBFou1tczWppi/XJR/1N5hILWFQ0vBhpR3bv3te1yDwxqg0ZZbJWhGiEvXifFj5QUN
	WEQ2PiA9ySS4BTONE1CasJQTEoQyNtKal64qkTGuEWjsjkZywH31ZcTRR67j5LAtwxPWV+P8cnM
	B5iT4RCC+Lyj2KcqjtbxOpMR091XxVuDvM94I1AYfsXex5zwF+Ilg4n/BLFKl+KQqhyF78apuXc
	BR4ZoFKuHQMToZXwjhglBBjC/oWrr5exgo1BybmlQE/YmGlv9/OhI3D2WSyoniLHBaUizqGP4Sb
	ZF0LH9+IeZs/rq7cS+qn+qMBqFEAlEEsYAle+r4LnGl/US2mUBf9pEpGnpXbRIONTrXWfXlmCVR
	9WJwJVbcrSP7oOg==
X-Received: by 2002:a05:6122:c8f:b0:5c8:2852:36cc with SMTP id 71dfb90a1353d-5c846277c7dmr5049706e0c.4.1789133698207;
        Fri, 11 Sep 2026 06:34:58 -0700 (PDT)
X-Received: by 2002:a05:6122:c8f:b0:5c8:2852:36cc with SMTP id 71dfb90a1353d-5c846277c7dmr5049629e0c.4.1789133697651;
        Fri, 11 Sep 2026 06:34:57 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.170.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb357288sm6149026f8f.29.2026.09.11.06.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 06:34:56 -0700 (PDT)
Date: Fri, 11 Sep 2026 16:34:54 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Monish Chunara <monish.chunara@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>, Ulf Hansson <ulfh@kernel.org>,
        Kernel Team <kernel@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-mmc@vger.kernel.org,
        Nitin Rawat <nitin.rawat@oss.qualcomm.com>,
        Pradeep Pragallapati <pradeep.pragallapati@oss.qualcomm.com>,
        Komal Bajaj <komal.bajaj@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH 2/3] arm64: dts: qcom: Add SD Card support for Shikra SoC
Message-ID: <lubx7heokegundvb5yndi5g2kaw4jol6tgegyt5qt22axf4piq@jacg3xx3ooyg>
References: <20260911093932.2376058-1-monish.chunara@oss.qualcomm.com>
 <20260911093932.2376058-2-monish.chunara@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911093932.2376058-2-monish.chunara@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=Bv8IUoX5 c=1 sm=1 tr=0 ts=6aa40383 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=po8fGBi+ks8MzcVQGuqtFQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=Tcdqd_mqXDpkZi4He8MA:9 a=CjuIK1q_8ugA:10 a=zgiPjhLxNE0A:10
 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-GUID: MtQ1Ykl26ZZaIufJMqlpOvHZQBBoxjxK
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDE4OSBTYWx0ZWRfXy3YVLrgA2Xub
 0t4qtPkdKgvUsT9dOxxjLTcRFtYxkbbV4//R3vpkQtaPw2CF2ZS7V/JQ+0cevXWvCjvMmoaXVHe
 gMINmY0a01ESseLG7JX7u4PwKESXUnA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDE4OSBTYWx0ZWRfXw9M1q1spW5UZ
 UGrJJnP1E+RxsMENbwSfIZK7DA6dXX2BbVJzEjKvVSu2W0QEmILR7BKYPmecVh0HjaOzVOnclZM
 VkIzMpt49L8skuPZCn15Kt5Dm+0ecU7XQ1rV6KG061HCBiOjVlcQBaB6Ba3a7coDgz57+BPz04+
 wy/Z5Upm2ks2EyH4C7OzY5y7bmJ4yv2G6/w3kQ0akNmXprD/Oxwxk0in0fup0taE2BOBGzjZvV7
 z/kuaWGUR0mpfP3mwLpCtIIVFunhx98NwAnevlReCOZ05ssgDZpcU+Q+LEbXuceMBaqh++8IBJl
 N45/BCo+ocBJoLZuIFWWf+Uue4C6Zc5B/XNRv10ASkcLFBzeodWgJW2cDyt8hqNAo3UM2m1clKI
 wLm3A+H+tjXy3eewH3IvEovoWrKwlrTcSoBdtQAxGKhhDlOTrMBaOUXoKbp+2dalQQDTL478AGr
 5ECdURYesCONO1CEPag==
X-Proofpoint-ORIG-GUID: MtQ1Ykl26ZZaIufJMqlpOvHZQBBoxjxK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_04,2026-09-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 adultscore=0 clxscore=1015 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110189

On 26-09-11 15:09:31, Monish Chunara wrote:
> Add support for SD card on Shikra SoC and enable the required pinctrl
> configurations.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Monish Chunara <monish.chunara@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>

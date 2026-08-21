Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F7B331EC0
	for <linux-mmc@vger.kernel.org>; Fri, 21 Aug 2026 10:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787309183; cv=none; b=FeKw8j5KIXfAAnJWMcGkBxZxHU9Cp1bhjwGxi5Jq8luDXsKEcGvswk3Cd7f7IqNzG8+ANuruEwZ1c4oZz5OsMx5DHQtTE1s0dsqhaArhDo6Opp/Rzwjs9ZiN4JDh7BceUlOWU6iGGfk6iFR2POnQonEp4XOxqv74TieTqbAzKXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787309183; c=relaxed/simple;
	bh=WAp8BWIfn1XFKrPCM+JNcNjLvJK53YTI3m12NkCOF3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VUbAoYbrqr8jdw7N9DvXYP+etpODmMILK4nQ83pbnih+03LMj1atHVkRayaEfwfDKUHxL6yARAyKjs1xVsUrzc7eQbhJFeAbYBP7dDA/ybOe6TAAATCQQoDl/+hPaVbqFDRFcjrKAidFZC90Q4NBHxm4E8SYiXV1zb27rslx2vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AerX+acM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CZjOHx62; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AerX+acM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CZjOHx62"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67L9M6sG1896295
	for <linux-mmc@vger.kernel.org>; Fri, 21 Aug 2026 10:46:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=3UwbIxGZNz/tV2i84xKOmTze
	+G/DpYkaZ2S5jpq/KCg=; b=AerX+acM2Wk96NGFueuplwZ43sRiYOA/Ss9Z2HPB
	GEp1zDj/ImYelP9szzJRfSGTFiSu2RCGH8WkSEKloYYxn8Jjqmt/5GZnGAYHXUH+
	Y16/y6zTAuuLcfu46Z1RnyaRh11UcY95ZxhvUDIdSaEUAHlncESYHhDYiHxuJWr5
	r/vIww4JeHtxBQsZ9Ms5zBoNufurNSb+42Md8DzZQaSdOvtK4iH1pTkVY/16q/sv
	sdxaRqflOpkcvPX6TNfhs0Pif3ZjIRAKq3cj9gDF6tdq+78jl7F6y1bSUI0jdj7a
	lRLw0jVd3TjNLfehkxO4eOwFQJZCHRaipfDKMgv2yxK9LA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g6gdn96p4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 21 Aug 2026 10:46:20 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38f57e31b6eso746444a91.1
        for <linux-mmc@vger.kernel.org>; Fri, 21 Aug 2026 03:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787309180; x=1787913980; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3UwbIxGZNz/tV2i84xKOmTze+G/DpYkaZ2S5jpq/KCg=;
        b=CZjOHx62PpH1VgVnGyBPMDP3JSMojUQIACUuPN9nB8yd/kSQB1RFjspNtdkflHyynE
         VcvLV0E8chL/Uq/omTlyaFsL3fNKkt0kNfiXs3Q6RLDCuTghDkOfdlFcJF6MQ12EhaTO
         nv7UIJTGHEwlWEOod045MSjsNn8O5jnUJl78+Fq8DqZyJRXM/Y17sBj0kF/IoE/oufVA
         VYt9quZOS3r0TVgzIL4y/pCF7dzSsZGJ66IDE+/VH7HL0FIjGvMBWG6jF2cwMvRrev5M
         xL+9CjLg44dkjwuZpt7j+ZXWPyNrd36Obcpy12A7YRoMiGTqrMaWDiI1XLQVZvh1Z/R2
         N0Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787309180; x=1787913980;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3UwbIxGZNz/tV2i84xKOmTze+G/DpYkaZ2S5jpq/KCg=;
        b=UXkCgrC2/W9s0DyHsjEMiqBPSiHrkLX3Pr3pTOpHJhVh/DZrVwjCe8ac7SekZM89GN
         nZJnBqKNIop+V0KzaZnOnXtrIhlOKkwtFpFXRO9K0W2huElPSXp4OFgEQtx2M5eAJfqi
         q7xMQH8ZnYClC/MPy5LHdkJNgPFY4oPAa2jqQN8zdK4wmiZbOhnl5bwVfP8vKSUgpcCg
         TkF0A4kwTkfnCnhl783YbzhEet69rfpoHf4NhAfUhpaG2+PcpUJn372iehH4dnS3kWor
         md2y3iFj/3AV8d/Vw34qB0J0OHy2p55GaGAe/XeGvQIwHGnOwi2fG9hle644N/V/XTe7
         VQJQ==
X-Forwarded-Encrypted: i=1; AHgh+RpbNqsXL/j/T3H9kzi9OOIxDOVcKA57jLiRrKsp9tuLjYC9vBtrFmYpJ4sLHU8LIEVrm3qon8GqeYk=@vger.kernel.org
X-Gm-Message-State: AFuF++l1chbwIY51h8bX/CocvTQ2nuh6wBOOLHacPeWgYceYPQb+Tosq
	pwz4sFDdJwjTXdKRULHn8Al4QhXLrrpN90EtDBMVxYUCtPqkNJRUmA9PojD20TPnorrFFy8aOve
	w/HetPp2+xC33WNBd5Dikmm9jhXiF25CoknLWQKVWdPGho7YVJtWlKRsdDrCMpWw=
X-Gm-Gg: AR+sD12sUcaz49MtpBHByvr49qSoQzCkakyNdppheA5hA9SsjI0NeE74H9pwF7hfgUg
	c1NTmEaKxFBduB1KTw4XjWplQ+rm6q5fBNkV5Q3Y8HoD+5e/7UyE4hktAj9ncsWqJDeTC/0oKyv
	Ay9jXVVJ9hUWX5/Ym0tzIJvseoYFGKRXyLI/APlCTXwiQXQUh7OKtVrw05shKtSSjdrOA1Anyak
	ZtXSjVdxzvDtcgOk/XK8d22maDbR+P3IeSw3sk/a/eMZP+DFXpgTEOyOt4nuwo8UKbbZlA2mAR7
	upu79/hus25WxGViqB24OaRaWAI+MAi4vspDPAerkwIXfD/Dlunx5OgqGUBeg80Rtr9cGAra+Ip
	/fYEDPpMzNloMNqubJWKg9EdBX+9cm355mi9wNw==
X-Received: by 2002:a17:90b:2d45:b0:390:b41a:b92a with SMTP id 98e67ed59e1d1-395c339eca0mr10683627a91.4.1787309179713;
        Fri, 21 Aug 2026 03:46:19 -0700 (PDT)
X-Received: by 2002:a17:90b:2d45:b0:390:b41a:b92a with SMTP id 98e67ed59e1d1-395c339eca0mr10683377a91.4.1787309177857;
        Fri, 21 Aug 2026 03:46:17 -0700 (PDT)
Received: from hu-arakshit-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395c4c37996sm2558815a91.16.2026.08.21.03.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 03:46:16 -0700 (PDT)
Date: Fri, 21 Aug 2026 16:16:08 +0530
From: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulfh@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neeraj Soni <neeraj.soni@oss.qualcomm.com>,
        Harshal Dev <harshal.dev@oss.qualcomm.com>,
        Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v11 6/6] arm64: dts: qcom: lemans: Add OPP-table for ICE
 UFS device node
Message-ID: <aogscHpyr6M7+jAe@hu-arakshit-hyd.qualcomm.com>
References: <20260609-enable-ice-clock-scaling-v11-0-1cebc8b3275b@oss.qualcomm.com>
 <20260609-enable-ice-clock-scaling-v11-6-1cebc8b3275b@oss.qualcomm.com>
 <71f41225-226e-42b2-87e4-2c8b082aeae7@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71f41225-226e-42b2-87e4-2c8b082aeae7@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA4MSBTYWx0ZWRfX2sCGeGFoUO/Q
 K+2KzAJyqF0yk9xBhC6LOaAbUlKD7LgT+ueQhE5LoGaa2KykZCIGlV920VdSw7CSCi0I2y1cYwc
 wi+AcRewb84MlMIFIfV/kkOhBFybFKxv9e3TEk5+6Ztz8xBKjax6p7N+Uh+N27NXZ5SytbIMysG
 QmPgJmTlD/htl6Tmjt0yo7BO+tnmIUHbKhFUvM8SMY0hl6os2pbOONvbsyfMmHLngb7xC6inZlU
 OurzqST55KxcJNJi3r3wtQmdDmTOa0zgHRGFXtpX8RDurzDvwpKmpR2CuEFRHXxlltd4QPhOw1h
 u6nszX6258JlyfyAo4q331rROwqPdgycH4ZnDoIfQlCZQ97eEll+mMMAyu+HIZ73AQuiGirKKrx
 5Mb+vCFWChuiTbliIFB3C1gPnKroRkqcrTLN0eHgkn1A7kFm8ZVyE3kVhOG8ZUwmT6GK2p5RDri
 1pIgd3EKaoC/dIB0vgw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA4MSBTYWx0ZWRfXxtbfLghHKdky
 2Q7IgyCbexUnT5GL144QSAFCgBMcj8wdI0GGgbVq5qje7nSsBBR2Nu5NjaZBH39FUy8vx7D8Zp8
 CFCRAei8J7iFBoAARVDhok1ePGRjIgY=
X-Proofpoint-ORIG-GUID: ecxCs-loWFPq1ueRTqGkYeaMT4b4qbhW
X-Authority-Analysis: v=2.4 cv=BJyDalQG c=1 sm=1 tr=0 ts=6a882c7c cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=oKECPZB_XDwA82e_iN8A:9 a=CjuIK1q_8ugA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: ecxCs-loWFPq1ueRTqGkYeaMT4b4qbhW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_03,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 bulkscore=0 clxscore=1015 impostorscore=0
 adultscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608210081

On Thu, Jun 18, 2026 at 03:05:27PM +0200, Konrad Dybcio wrote:
> On 6/8/26 11:47 PM, Abhinaba Rakshit wrote:
> > Qualcomm Inline Crypto Engine (ICE) platform driver now supports
> > an optional OPP-table.
> > 
> > Add OPP-table for ICE UFS device nodes for LeMans platform.
> > 
> > Signed-off-by: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
> > ---
> >  arch/arm64/boot/dts/qcom/lemans.dtsi | 26 ++++++++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
> > index 353a6e6fd3acb22ef228bee340212b8b2c300957..f100d706edde465730873702f0b0a00b44050c23 100644
> > --- a/arch/arm64/boot/dts/qcom/lemans.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
> > @@ -3109,6 +3109,32 @@ ice: crypto@1d88000 {
> >  			clock-names = "core",
> >  				      "iface";
> >  			power-domains = <&gcc UFS_PHY_GDSC>;
> > +
> > +			operating-points-v2 = <&ice_opp_table>;
> > +
> > +			ice_opp_table: opp-table {
> > +				compatible = "operating-points-v2";
> > +
> > +				opp-75000000 {
> > +					opp-hz = /bits/ 64 <75000000>;
> > +					required-opps = <&rpmhpd_opp_svs_l1>;
> > +				};
> > +
> > +				opp-150000000 {
> > +					opp-hz = /bits/ 64 <150000000>;
> > +					required-opps = <&rpmhpd_opp_svs_l1>;
> > +				};
> > +
> > +				opp-300000000 {
> > +					opp-hz = /bits/ 64 <300000000>;
> > +					required-opps = <&rpmhpd_opp_nom>;
> > +				};
> > +
> > +				opp-600000000 {
> > +					opp-hz = /bits/ 64 <600000000>;
> > +					required-opps = <&rpmhpd_opp_nom>;
> > +				};
> 
> Analogous question for both pairs of frequencies
> 

The same rationale applies to LeMans: its UFS controller supports 75 MHz and 600 MHz.
These ICE OPPs are retained to better synchronize the ICE and UFS clock frequencies,
even though both operate at the same power level.

Abhinaba Rakshit

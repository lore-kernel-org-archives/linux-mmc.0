Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD41293B5C
	for <linux-mmc@vger.kernel.org>; Thu, 15 May 2025 08:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747299174; cv=none; b=s4lpicAIF5uAnvFrhDYuj+8nSpjoBqxXA3Vz3im6t9OVBitXO6SWeoCJMFOTaInGmEUwhsCRKGudm3buCZSSgtp4V0NZoNTnL3dA1JwZy5CE+or58jRiiIr7Vtpp9WpcIGpVxpLmh6HhlxBGfs3j8EzEbaPl49llzaS1/Gaw7mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747299174; c=relaxed/simple;
	bh=FI7sGTrB08Zo/oscENddwqf8I3VuN6qo18yWXr+NkPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jxcbaq+hgWeIJjghK/jMpi+cB7iPcbAMjTU2adSPVhsVAlih2z/gyKEVukwbPtj00fEEkedCzN9iZuvA9fBUM/YAMru+XWNJ/WW0jqNWRz3Yvs3Q+Dp6uiYrRK23feVOvmY1PTsXxiK8x7foZCvxi91/in0XMhPef52tevAZn0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pvZyz1WA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pvZyz1WA"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54F8iVSi030342
	for <linux-mmc@vger.kernel.org>; Thu, 15 May 2025 08:52:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=hwaZDQYsVUdsi74SztNN08gE
	i0Qf+CiwpH9GUcd8v0w=; b=pvZyz1WABqrH3iWFcaH6vQ1u/BofwUf+zlSTmbca
	/dtZ75XMShxjLA7z3o2km1eX32eTFN3vj7WWo64gD97nTJc5Iq5VrS9M1fKNeqnV
	L6aaBdTaCEvItdmB3GwXe2Ko9erqm3IasMhQOE+BBz6v9GC+TCRcYSs1OFL22qfx
	sEIXlO/YIHA27Zrt/wlS0uRU011F2tM8BKF9AvgnG30bRL2s2pbM15YYTP/dajJQ
	ekTECu0A/5rS8GyIb8H5UrnAVWTkdx9V5j9i/64Uls0XU8Fysev5EBPC+k6F+6Rn
	IC7iaOxArCCBDLRUCsQ46y2SOYLHldXTjTK1MZS0/eJr9w==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46mbcnwjss-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 15 May 2025 08:52:52 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c5b9333642so64605785a.3
        for <linux-mmc@vger.kernel.org>; Thu, 15 May 2025 01:52:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747299171; x=1747903971;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hwaZDQYsVUdsi74SztNN08gEi0Qf+CiwpH9GUcd8v0w=;
        b=j4isk1+UfzVV9cmrlTWY2veaEf8d86LURVM85iFhHM4PRVBFtBN2gKxJObJ+VYtOPb
         jqoLdeZPhnMPwIqy61XZol8Y5UZt7W1uh8z1VjZKwSNJRMcfXh7TXNtpNz2VHYcQnMZu
         +KUhrMx572y5ZKuPwO96y+BkHPd1iiHPF5/TH9ET0lJbGjl5X67ntWb8EEvGMhcWoJPt
         NRSgqKlZVitNn1Nr8vJxY+qilNzHZwRfIwtctOjppQbjiR1nP4xYQ51BEe3rFscgN7yx
         p0TDfxk1jkt8vqyftjh9qXVWzqLaBQ+QvBvSnI2gkcE5Y7fB/sSeObIQAczruKwgDQZ4
         ehAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXV48Fs+WFrTH6GfNTFqK/wldThDmanuvZdetQygwMI75WduPBSr2jrcnT6T5Rc2e9alzVd0M3Otmk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ0RroxTiR2Z09kkml2vi220c0J2kUZOVeu20I4yC2BWXoTvXM
	3i/V71wK6MajxF5RD07w6W+rKt57yBQrJar9iEl/Rh/Gh1WukxBBKAR7jjN69H0/inqMvu9DMje
	UZgRs4r1XH5wv4uIA9aMRhBlv3sFjI3xTadCpMKC5frl+ryy5aDePx7521E4=
X-Gm-Gg: ASbGnctFVHws/ezs7vJdTqk1AyZkNlFbXbWesb2sLx+vpL/H2V8X8oHvdc7t2R3/N2p
	c1BijiplQhecH9jS081LM6nPsJB2CmT8CjgZ1r0ugl4xeryDDd1M5Jnkn7wcPLuecjKlhsenJw5
	UoUEr6ft2dLJA81W4XTlJNyASMnUHQaMQcUSTe0pTTuh1xAELqEKaV9HRME+j74x8sNEfdiyaAk
	k/M1sKoDslXCIMV0VreaIHdS7F1UCIMiXmdqkJW0wgP7e282s1cSqXTqPlGFEJvUavFh43ZTfub
	/YfDN1v568aW+opGY3xoTyxjhXNez0bU4ppYTDT80AYyvx5DhS0ebp5PHmUPz3IgxmcBhj4LKd0
	=
X-Received: by 2002:a05:620a:c52:b0:7c5:464b:6718 with SMTP id af79cd13be357-7cd2888faf1mr1253263585a.54.1747299170888;
        Thu, 15 May 2025 01:52:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQ+BiR4gB9vfsEDZ2lofj7FH/2yViqW+rJhsM6lLhCtfcarFZ22RLGIEcYHdLuh4PfJ1Riig==
X-Received: by 2002:a05:620a:c52:b0:7c5:464b:6718 with SMTP id af79cd13be357-7cd2888faf1mr1253260385a.54.1747299170523;
        Thu, 15 May 2025 01:52:50 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54fc64504c1sm2555886e87.52.2025.05.15.01.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 01:52:49 -0700 (PDT)
Date: Thu, 15 May 2025 11:52:48 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Sarthak Garg <quic_sartgarg@quicinc.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        quic_cang@quicinc.com, quic_nguyenb@quicinc.com,
        quic_rampraka@quicinc.com, quic_pragalla@quicinc.com,
        quic_sayalil@quicinc.com, quic_nitirawa@quicinc.com,
        quic_bhaskarv@quicinc.com
Subject: Re: [PATCH V2 1/2] mmc: core: Introduce new flag to force hardware
 reset
Message-ID: <rkmqeiyha2wldtm64ndcs7hssqvwsrqr66kwh6w3exbsyc6c6n@xhqdh65af7hx>
References: <20250514111155.10896-1-quic_sartgarg@quicinc.com>
 <20250514111155.10896-2-quic_sartgarg@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250514111155.10896-2-quic_sartgarg@quicinc.com>
X-Proofpoint-ORIG-GUID: RyAaDUvK2XTdGViCJugW4kj31qPEvZI8
X-Authority-Analysis: v=2.4 cv=D8dHKuRj c=1 sm=1 tr=0 ts=6825ab64 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=QyXUC8HyAAAA:8 a=Dw_yFD_fkBKW1skOv8gA:9
 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDA4NiBTYWx0ZWRfX9k6jlk2ADlex
 ly1oEzCd+CML2PrqHHN3zYq0b+zEuFyf/d2ohoAWXLWYHy9TEoEWyANEUJFTDRlh/0CjGBaJGWD
 XLoTMYIkpZyas1Tr9O6aCsIQimUVUafl9C3xrQqrrKFYKoxHan+EjHpWetQ0YDQ2uEBNuDkmqLd
 GxrRQK2VUgD5JlJSKDscMOq8J42oen/U9+BszJk21DIJxdVI0NWmveEEv2IxRp9vFCarn/0luY0
 nPqjK/gjuC6bbShI6YcVkAjyIGZb/Bbs4DeK0lq/a/nvM2xp/xgde5zbn/V5+BadVDHzstld1MB
 8WtLF7tn1wwR6IpbTgpY4SB/T94SzeSBTPGZI1+uupDgeGip9r+x4BJ+D4T4pacj8SS1D0pCKRN
 S9VVWu6gCsV+vyyG4RhLZJar6Nem2dHZ0pTkdzwP7pf5/p7vjblOK7YxVputeC9JuCnfPvDi
X-Proofpoint-GUID: RyAaDUvK2XTdGViCJugW4kj31qPEvZI8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_03,2025-05-14_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505070000 definitions=main-2505150086

On Wed, May 14, 2025 at 04:41:54PM +0530, Sarthak Garg wrote:
> Introduce new flag cqe_recovery_reset_always to allow vendors to force
> hardware reset during cqe recovery.

Nit: CQE

> 
> Signed-off-by: Sarthak Garg <quic_sartgarg@quicinc.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  drivers/mmc/core/block.c | 2 +-
>  include/linux/mmc/host.h | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 585c2b274d98..dce2fb762260 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -1622,7 +1622,7 @@ void mmc_blk_cqe_recovery(struct mmc_queue *mq)
>  	pr_debug("%s: CQE recovery start\n", mmc_hostname(host));
>  
>  	err = mmc_cqe_recovery(host);
> -	if (err)
> +	if (err || host->cqe_recovery_reset_always)
>  		mmc_blk_reset(mq->blkdata, host, MMC_BLK_CQE_RECOVERY);
>  	mmc_blk_reset_success(mq->blkdata, MMC_BLK_CQE_RECOVERY);
>  
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 68f09a955a90..d686adf75293 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -554,6 +554,7 @@ struct mmc_host {
>  	int			cqe_qdepth;
>  	bool			cqe_enabled;
>  	bool			cqe_on;
> +	bool			cqe_recovery_reset_always;
>  
>  	/* Inline encryption support */
>  #ifdef CONFIG_MMC_CRYPTO
> -- 
> 2.17.1
> 

-- 
With best wishes
Dmitry

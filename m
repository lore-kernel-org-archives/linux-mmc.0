Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF81F4483A1
	for <linux-mmc@vger.kernel.org>; Fri,  4 Sep 2026 09:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788514909; cv=pass; b=WSqFAsyZhJFPxNSTnglc23XGRPx3L2GSktHTS3OO4LWtGY3SlNS60mBCQUXLIWi7PbT8Gq41PvYrBVHZdB2RfQlvJffqst1cjWwhGcR2shQcLMvl4CGxYwmXvFT0prTPWOlYv70M/GfcYfVteJSaqtaW5L45r7sNSUZb9gMRZBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788514909; c=relaxed/simple;
	bh=50uP1eicgdZrDAdIF1X8QHzjHyrWCQ912G1iM8kMKvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gCLEeK4QatIOq3yhyitPzBwYLWBz9vzdUWcDtWI8NIhxP5pU/xzGdLC5Gxb8xbGGUlscQ/MMH56Ce3HWRU4w6WZUknwEFvl7ZenLlcxjyhgHFIwrJwU8Ze7qf4AQ8wmqL6Lb/RCHeJzZhGzEd7M6+QP+mDWb72WEUw6GaTWFC1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WOnHgtd+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IjZkDA8m; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WOnHgtd+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IjZkDA8m"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6847n5NT2839766
	for <linux-mmc@vger.kernel.org>; Fri, 4 Sep 2026 09:41:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JldoHfs12k74dRK0ZkTsEc5gWGEjCULW7w5FKztiviQ=; b=WOnHgtd+g4Sfp0Hk
	ELZWXPYcMvA34BuPdsdmCIjRKBfex8mAm3BOPnr80WCPsPc/fvz8c4OMkchMC0gs
	hhJnUU+y6TJoP/YyuDqiRrOlrc18tA9SVrDcJAPQsz+BjrzawZTmF9gozQU4ib/f
	EBB2dZarfnLeReRTa1IvG9wydG4O5jFD0xSCh+84YVA2E6wb2iFcZeivISwaqxnx
	qqR7+QXl2n5TVbj0lLvlXfnbiA/pQsZvTSFzU1630gxgIEyff1tsx3EWwx7jf0/a
	vdu5ixJfaKjsa29C3cnmlBqpZT6SdDt1fMdxmAexlOnmdk4ag2Dv2wqoGvpxJcV9
	kqdsQA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gfqqtrtqm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 04 Sep 2026 09:41:46 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc132709c76so1250649a12.3
        for <linux-mmc@vger.kernel.org>; Fri, 04 Sep 2026 02:41:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788514906; cv=none;
        d=google.com; s=arc-20260327;
        b=JSTLFipCrl4AkBQMC50vcmGweMuVRwZMtbCScy6PUmZHYTY63Y6yEEU8Wau43qLtQH
         VvXv2jsVR9cFiWT2Xcjz1OMmDDwUvAVaTmg344Kp1rMPaadCO6folYhtNjrBQG9vzVSO
         cD0x182uURtmScEA3cxWpKgh3WzOhJzMOpgJTJqR0GSs1A0vtsc/s8kC+iEuKU6JIuZE
         jCpfnfPvy0rySwjAvFgobivbM1neOAWxD+xsVF7Y4nhlC4qq8xylx4QBdUEtDVfow3CD
         GNUCbLXJK2hyMoznsHdNagl7gIt6X5VM9jfPlxTuwVXQ1UzLc2lPUjEe+QkQfOxCwTKV
         fikA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JldoHfs12k74dRK0ZkTsEc5gWGEjCULW7w5FKztiviQ=;
        fh=aGr1e/d8XCa/9TtNe4T4++OwVQDCB0bdeSUB1JqFCl8=;
        b=CNxJV1bIVus/27Y0yFJ2/GpS8l70JerbQGOD7aduV4HSxTP2O40Uh7JEdD/S6uX7kq
         Il7sfSgwQ1sMRuv87v2cr9PTa3YDO0fA0XDIHmeYnI5RGSb48B32AOLmTqyoEMmajQNy
         2k345tbwLEw1GJqHLkao/sCbRc9Hl13f/0Z7Tc/GSPIKCj3xbN7wKSE3FMds7xSLXI+a
         nbFK5TGgTNTkF/3R2+kUslf8pDrp6dRcrOOPYWrQY6y4WGeGvIGA9T8eJzUS90FKp/Eh
         jSx2X3eBFAZTEQxHKhPQ80bPWQ9nv3lHN6HrPDtGUHf0Q8yKNR37iBLplYy+1EXL36cJ
         +jZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788514906; x=1789119706; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JldoHfs12k74dRK0ZkTsEc5gWGEjCULW7w5FKztiviQ=;
        b=IjZkDA8mYmlNSEXVI2S76hlYMbYjzKPPqNYdaKq6+kwYdMtbAGnz1Ad4DTvjWr+Ysb
         55ZMjWYbGYR2olp4oFrO9LGn0zyGuc8mRwaWNCmUjcNRgbcIRtiv0UaT1ZDzDbDk3Mo0
         9KP2Q2VcFmdlwIfwUjQKldHTuyRa2Yh5/aKAmLuxcfJxuBR2gjK91NaLUvGQlswtK+Jf
         tJDf5aUM7rG9kbyLrs73Y6rsYfoCJEjak8WVfc54XMmr5j3dXosC/UmT+gZLOm4KfmVc
         FlCz5FUaNLCZbII3vAi2Qy7QSyqQA/ufuCLeamXhf9ZK7ACiB6SqdA7LsfSjUHY3ABFR
         FZTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788514906; x=1789119706;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JldoHfs12k74dRK0ZkTsEc5gWGEjCULW7w5FKztiviQ=;
        b=g8vrw8L2EkSIQQtVzdxHtYAUrTRZyIn1eu/6ths5KeGx5/OEyRyYMJmxX4E7ivzQim
         xXuTRjz62lQLlJxjcx+yMxP/bVFBSMqUnjLVd7F8u5Jy7N5mPe6u1WtOAW/J0Tw5ftTA
         12kseiq4fXoO+6POyLq5mA1SpqqCvwpx4Q4WxempzC2Zmv2SE4to7pJ4nAQJ+s0M8fue
         zYGjvZzBzAjILDuB4b3ZQvHDN4GkvadOfTAmwy4lUuf6pOSG803v4NkQzJINJL5JCUN+
         HFyyYyoZAar0GLKGr9LOq+KUADttBr/zkwNNBMoafTl45WQGSWRN8EqKwlHiE4fOBG1w
         TBaw==
X-Forwarded-Encrypted: i=1; AKwUvBzGp1ihiUq+l3ngFumv7rfbg0+HJo2opsXLC74JK3/wAJrU1wUXO7r/5MNrNM/AeZ0ckc7Srr7iIj0=@vger.kernel.org
X-Gm-Message-State: AFuF++kDnMKgH4/c/Ai0Cs35PZdu/jC4OeuamXOsPckCxT2kG3+MfvQe
	GOSGf4SesotmcTrzBK2nCgPQCVfILD7MwVgHqiJBRQ2BrjCx5A+fg4VUtYOEVzAsaImG0Yc55t3
	2TCblorfztYcnR7xgVj7tajsMxp0ZoxWhWj0jMVITbHJJh33kqdP4kJlj8jwY+f9f7j91ijOPZq
	8wwscMRketrM7cfherqFqF9VxbfYTotbNfhbj5FQ==
X-Gm-Gg: AYBFou2y60v4LKpCDdesFLeelTUkTpr2dJs8RQy0yhcY9mrtclti9Ol0USM1QRS80eN
	n/9VUFPpjamhCvRrdHTpK4V8vz3xBKpVCv/eXjoAQ9d+S97vIUmR/b73duyZAx0xwuiILhnjIQ0
	lFThIjqHuOX6mRi0inp/Ht/LjMDDAXM1otyaHHIycfjzWDHJ0fNL71aL0hvA==
X-Received: by 2002:a17:90b:2644:b0:37f:ed7e:7e42 with SMTP id 98e67ed59e1d1-39b26204e50mr6922765a91.14.1788514905822;
        Fri, 04 Sep 2026 02:41:45 -0700 (PDT)
X-Received: by 2002:a17:90b:2644:b0:37f:ed7e:7e42 with SMTP id
 98e67ed59e1d1-39b26204e50mr6922718a91.14.1788514905397; Fri, 04 Sep 2026
 02:41:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260814082550.211496-1-fanwu01@zju.edu.cn>
In-Reply-To: <20260814082550.211496-1-fanwu01@zju.edu.cn>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 4 Sep 2026 11:41:33 +0200
X-Gm-Features: AcwNN1X7jtNoULHEL26canlwRNl7gaaalnTd8u1iDOV2xMeca3w1nhpVHiz7hJQ
Message-ID: <CAPx+jO_NZOWDKDkQ_CkMPRdcG=mR7fUScPFS+urYu4qdCD0veQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: mmci: Fix use-after-free in busy-timeout work
To: Fan Wu <fanwu01@zju.edu.cn>
Cc: linux@armlinux.org.uk, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linus.walleij@linaro.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=YtA/gYYX c=1 sm=1 tr=0 ts=6a9a925a cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8 a=GXuGsSDVByYryeoQmGwA:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: ws3RQ0ZmAxvjEd6obAmP_fjDf_xwFwRT
X-Proofpoint-GUID: ws3RQ0ZmAxvjEd6obAmP_fjDf_xwFwRT
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA4OCBTYWx0ZWRfX+6aGVVY05+DP
 C7cMagYB1MD9cAFAijB7kgVh2z+HOKYRRSVJyEQZ9N08204wWYHvdRPzFdRegr+mUU0h2LPF8W7
 SiT4SvFUeoEEr2pDvNbxROtzixD97l4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA4OCBTYWx0ZWRfX46EtG4y+56YQ
 BmbnenspaWAmR/O5hiwirWMngwvU9UsgvT1EfuQCiLC/OWWTTo2VLOXKS//SN+tBs1M9D/jxsZH
 sK6r88+I8XVg9V7bNlqQ9pv8zIR0WOBgnzcBbAbRGUTIAJsLZ0QuvUEiEMtV3GIJvOnJMJM5Wq3
 MCj4ZSfvhwCREp1+z/tHrB9WK1xrIo0ZjDuIs3ZTylltavyTtBsaOijaXKiOLwEfPMCXIJ24Gt2
 aLf3TpU3pPqFUCXyAEWpFEgRC3T8yOFUrOS8mamLa0U7M3hYYDn1WpA9oDza9gA3FW8r4Y1JwOV
 CcUwhzEXNE7jr4jqt/u+6TftYyQLnM6TLNszH4DfJd3wDCKiTPh0NEOuCJIGnp1jggHiK6ygHfm
 dIEStIHYPtxhiFtp7T8R5KudPlveSrGfsnDjIz5GhPfstGTE64tvEGACIgV3AVMYcmoE1HW/oU8
 laSsZBxurKezORJYocw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040088

On Fri, Aug 14, 2026 at 10:25=E2=80=AFAM Fan Wu <fanwu01@zju.edu.cn> wrote:
>
> ux500_busy_complete() can queue ux500_busy_timeout_work for an R1b
> command, but mmci_remove() never cancels it. The work can subsequently
> dereference the devm-allocated mmci_host after it has been released.
>
> Mask the controller interrupts and disable the delayed work during
> removal. This drains any queued instance and stops an IRQ handler that
> is still in progress from queueing the work again once it has been
> disabled.
>
> This issue was found by an in-house static analysis tool.
>
> Fixes: b1a665932dc2 ("mmc: mmci: Add support for SW busy-end timeouts")
> Cc: stable@vger.kernel.org # v6.10+
> Assisted-by: Codex:gpt-5.6
> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mmci.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index e500051bd..416bdb184 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -2511,6 +2511,9 @@ static void mmci_remove(struct amba_device *dev)
>                 writel(0, host->base + MMCICOMMAND);
>                 writel(0, host->base + MMCIDATACTRL);
>
> +               if (variant->busy_detect)
> +                       disable_delayed_work_sync(&host->ux500_busy_timeo=
ut_work);
> +
>                 mmci_dma_release(host);
>                 clk_disable_unprepare(host->clk);
>         }

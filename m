Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03C83F823E
	for <linux-mmc@vger.kernel.org>; Fri, 10 Jul 2026 13:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783689685; cv=pass; b=Sm1DEuMiZ6fbF8nXaVuFV7g+RR4gg6Y1lzl+jZq73vjy+XJ1QQxaJajk9QrZE73LZzriMS6qAWWRCsqHMJW050RFHCuGoeho6JaNEfS9s1V39roUYI+1Ca8kJN2IBbxr0AkiTf0cJEAzKwS8hsQpw7FCliYple2N/KDiQRttsCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783689685; c=relaxed/simple;
	bh=yJUD0zjMXdXcwYNYeesMNh5Qp7X3KBdk0dsrOzLclDw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cCc40A5xOQHYcF8FJJcfkL+3JKkzzp4VEo9nO74Kclk33yLMjesmsZt8mcOV01REQU07DR8v0+mpnoAewkb1V7owhPKQAM2F4Pd2vi8lO/N+MM2wmIWIN1M3BpOkimBVLxytMrgv8tYfZ3EcVKXNyKyy/Piiz8IZBiM5L53/U5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=o+TAQLQC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YQqo3lr3; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="o+TAQLQC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YQqo3lr3"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66AD6bmZ700779
	for <linux-mmc@vger.kernel.org>; Fri, 10 Jul 2026 13:21:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Hd8Q85OSkSKXhpNfSLM1+hfK0QwlDBXjSK0VPXtD0CM=; b=o+TAQLQC9I9FhZl6
	MimcTmlH0/lj/ynrOqAIWukAbaXo+J6Piprg8+HtbADtE7oBP3r8hlMBRNxb3k3E
	lymL9WfByRPieGSG/b7c71LF5UqIml+M5fQQkX34wcw0nOcIW/6a4sDYRGZu45fn
	21Uon8bqwLQbpcsnD+fArZ6Zj0OFL8bNh8IuYu7qfF79vTs0cLX5wIswKbEaIUpw
	yWBnS8XbF2U7JxTxejOg23mpyuacb9YwvvC52QP9IHd7jZGrP2qiriNvL6kyhPP6
	jsIUtugIggub7RhTCnzDc6lXz7RNycPtLHcCqE79gc1AfVnRKn2uTnfXIbfqynkm
	qTcKRw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fahv8kfgw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 10 Jul 2026 13:21:23 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8fc6b670b4bso12734846d6.1
        for <linux-mmc@vger.kernel.org>; Fri, 10 Jul 2026 06:21:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783689682; cv=none;
        d=google.com; s=arc-20260327;
        b=mmYOMK6RAehRQHfn3s4UdAxONuRU5LgblOAFKPXaARAhBwzpacxdVBjyzNh52IsJey
         Ce5tc5jVwE5SPxjXDeuc0RsVfUqo3YqzDRd29eKkRviF7In9+nN5MjnW+D+vCaPqKles
         ZXxV74MY5anU57xC9dWy/KBMdy4nV2wb0wOCR2HkGmq+zh4JE36Yvkhk/Z9HjDJURv5L
         YrGLET5hZmMfr2Jt+nULXu47oio1kCe55QJLcA1aCf13Vsa1PO1jlZ8uhQblEGf1GgrC
         a55FFuPIHkY24eGHuBeNsRK+ob5Y7lBPAe7VsNoLtlRl4sJSQAmR6eih8FNdXh+p/H+B
         zS/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Hd8Q85OSkSKXhpNfSLM1+hfK0QwlDBXjSK0VPXtD0CM=;
        fh=FGBJcdbkrDlG0wjGeF2ieCc3G8B83JJK4NNdzCeH6H4=;
        b=CdsJBUfFIxxrQ8gzDWXl0qTWXGOrWexDYHhQz6w6oE3D1MrDU1ZPvuBWlw40rt14ra
         s+GAB/azr5Gu9mgWBDn37KxrWOHDalWc/G1D//OuuKS7ZiqeUTh8i0YnSGVXiqCl1ggS
         Ao2XRLSArEP+Ev/zp9o3j7rZ7TJWVCJ6CHKamxb1NVUQN7VvUhEl1GeyUDu2V8g9lle7
         tXExMRtriN1Vkb+481j9pYlZ8AxYrM2Yu2qXPEWMNojVnrDsV5X4gvQV2b60SLIBBHgT
         vxag5bw9QvHlDMPo+7Ba8O2Ja+2g3hGJeN6FHV6hbhKkCySzckc/jVq45xiNRJ6u8I25
         sv/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783689682; x=1784294482; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Hd8Q85OSkSKXhpNfSLM1+hfK0QwlDBXjSK0VPXtD0CM=;
        b=YQqo3lr3H9XLX+ee1xRaBVEEFMiCXiZ5w9h0glrXBB0WIFJGR2Li3Ny1Xi7+Xo8D0W
         TAFygGJFQ7Ak8y0NgWdmJNVat+4ZE+6ZPbEgqw6RvN+tOU9qKznvZ+BUW0hg+PSbyXr6
         U6fXkZiIKdw+TDMUecycKIBAivI9b6WE5iscMrCHYsDRjSPc0s8JXReyOUUxgXtZPeT9
         W5AG63XL4oGHRzafS/rDMX8me3bQlFVPYcyaQrzLtsuTYnwpMzWMOJk4cp9zaCvakhC5
         TEl9G2DDUeeii8Lt9ummmeP+T9JdC/x2IQHXd5Ymn+KxtQKkZaGjYimb8zozScezfkhc
         M8rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783689682; x=1784294482;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Hd8Q85OSkSKXhpNfSLM1+hfK0QwlDBXjSK0VPXtD0CM=;
        b=fEjGQlb0i6YAWL21zCittKY/F94pHEJ2AymaStWmTVYdwZag6YkoJ+TZ528QExrHMV
         q7fs4YHlwiE2eBJx7aSUMmWd/jwWeEp8dV1RMjlHT0pz1wr+WD1DcyYAqOSDW9YlyBVT
         UalZvfXsj0Buu+AoOx2xOBA/Spv7RHlbzfFQRstPw0/Ni+k78cyrfEWrbaPt7+bOQOKH
         tFrPyIi29vPSz2RFDugULxv2K/NQIjPx/F7n0u0PhDWXffT//62DURz0M20Cn0z8Np73
         B/hw8jBRleBDw9MbKBxDqITUs0t5+/rt3rsOIHZoZzYU/tZJvN0HyFn2DEz4MlX17eIA
         nOFQ==
X-Forwarded-Encrypted: i=1; AHgh+RqJGYFAL3tWT5tiavgsvIvT/O2EcUdpqnRh7AsKvxHc4DvomVtobhJzGXZzyfBG7eGdaZmpbm0fsMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqeGjfIEAAqFtL9aHc+5tTt64YdYl702i97wdta3/b6XWkk4NG
	wNTmPbZwfSfn5SHTNfC8t5klPG/o25+QTOXHCIPw8CKheSAkoqJcDjNBI5wdj5qeLFm0zJYW1Tv
	yqO6RjbpFZodPIy5ylAmE9tH9l/J5H7fV4hLyrr79IJABj+g2cOERG4SJsMl507Qihxh4SqLs2G
	IOdkwZn0131jVD4UdmcJW3mAA2o7DjDchhWPJy3w==
X-Gm-Gg: AfdE7cnnJjlbD6YiTeQFaQnetyAIaM+Zrt7vhLbwBwHwSikYttzaStAlgbgd97M7NeA
	UpfCUroNIl8WQuAmsxwvC6ob7S3I03x8khXpYdwr3j/JznLJtzgqS/dEvlpDChQLBveN8vfXlLu
	ZFVWXIg7M+As1DZVwQfnoCMPUtz81GCPXmXwv2UB2u4DpGjkBMx39P0CT5Np7TBNZZoGPx
X-Received: by 2002:ad4:594f:0:b0:8e9:f62b:8f99 with SMTP id 6a1803df08f44-8fec304a86emr121294586d6.46.1783689682045;
        Fri, 10 Jul 2026 06:21:22 -0700 (PDT)
X-Received: by 2002:ad4:594f:0:b0:8e9:f62b:8f99 with SMTP id
 6a1803df08f44-8fec304a86emr121294176d6.46.1783689681472; Fri, 10 Jul 2026
 06:21:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3425c3da-86fd-469d-a3ec-7805138d3e2e@intel.com> <20260706123357.1512192-1-satyansh.shukla@oracle.com>
In-Reply-To: <20260706123357.1512192-1-satyansh.shukla@oracle.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 15:21:10 +0200
X-Gm-Features: AUfX_mwzfS4wJ0Z7pJ0wLjHtjDPznbxqee0eWsD3XM9cMNkQkrXXYgiTP4TcNR4
Message-ID: <CAPx+jO8d4QXo1tW4W6HU3w8aGUWOdT05kAg=Y-N964m3ONPf8g@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: dwcmshc_bf3_hw_reset: Log eMMC reset calls
To: Satyansh Shukla <satyansh.shukla@oracle.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: MLLA0YpACWFtjzEpe0lde4xpWnNhS83G
X-Proofpoint-ORIG-GUID: MLLA0YpACWFtjzEpe0lde4xpWnNhS83G
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDEzMSBTYWx0ZWRfX5pp9gQiU5ODq
 hFqiCrT0SJ4tvk3nd2SoPMJYUdMsHVbSelk8BEQ4r2k2awpLoTipvvsHwVat2jzql/xo5M8zzJt
 UmUvWepGcohn6V6TBXzu5Cd+Aq2sIVY=
X-Authority-Analysis: v=2.4 cv=funsol4f c=1 sm=1 tr=0 ts=6a50f1d3 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=yPCof4ZbAAAA:8 a=UlL_G-MeZPnffcAmDnEA:9
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDEzMSBTYWx0ZWRfXyasrIIaoU69m
 AqK066CU9mQjuIqgi3Yry+RupyFDS6wZhHajdmNpmP4v9iUn6mEENMWQnX5NRT6d5pRuHt9Caos
 RrmEvs5I4Qg119Lf9q1Am6v8cGpyK0+8wVo+tN425+dqwDsEBQMLks52Rmbr4zd5auOnXjfp1ei
 cnVnavrJQt6dN0X6kGchwjow6Pj6arVIOhU321N9KAEj2ZFZLYbFRVW8/epDiY6HAILebnrKoFn
 guGeVDhdbFj89Q7y83dgb7yqkfDveThbLKBO3CKtYH6IeiQKYu9l2iP6qF6q6kzFapcvEmaRHMM
 DmwptTESnNfGOSyJHq02jvyVtAOse9pF4gZGuv8oNMxL9C3ZkzsV+aA3dkWpWbzUSfWuBUf+gNJ
 vAS7CkyZhML0ujIrANyAbecJIVmmM4uj5EBv5GFQTD1Top13r4Z3bpPRwwvldx/XR/JFMW2HO+Q
 GAsQQ0y1kF3wgSnux3g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100131

On Mon, Jul 6, 2026 at 2:34=E2=80=AFPM Satyansh Shukla
<satyansh.shukla@oracle.com> wrote:
>
> Log when the BlueField-3 eMMC hardware reset path is invoked.
>
> This makes it easier to diagnose cases where the controller recovery path
> depends on issuing an eMMC reset, and helps confirm that the reset sequen=
ce
> was attempted on affected systems.
>
> Signed-off-by: Satyansh Shukla <satyansh.shukla@oracle.com>

Applied for next and by amending the prefix of the commit message, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci=
-of-dwcmshc.c
> index eef53455b8ee..a01668b66e7d 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -2013,6 +2013,7 @@ static void dwcmshc_bf3_hw_reset(struct sdhci_host =
*host)
>  {
>         struct arm_smccc_res res =3D { 0 };
>
> +       pr_debug("%s: resetting...\n", __func__);
>         arm_smccc_smc(BLUEFIELD_SMC_SET_EMMC_RST_N, 0, 0, 0, 0, 0, 0, 0, =
&res);
>
>         if (res.a0)
> --
> 2.43.7
>

Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D435466B47
	for <linux-mmc@vger.kernel.org>; Tue,  4 Aug 2026 13:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785851009; cv=pass; b=qALh38QvzvuqG0o4qS32It1YjVwWbCkvVDan5l0qp8fNYx3znhheSnE1JiZxl5+8NxuuIfI9r0BFbL9vBoc4mvmFQ0hxoeG8OZltveSpKXm6BmqDxWBeMK10+nxvqRFRkz7ZKrb7ayb3s/Or5ZOefPNePm3n3MI0YQ8RQNCyGYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785851009; c=relaxed/simple;
	bh=M+IG3enzqCG2l4MNTQ6JwHElR0G7k7LC0xIIRxpU7sI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XOOg+mESj0gg0d4G0yQjct1LQk5WHELfk86JkgLYsdLOdU+/yym9riDcVQgoK+hAx8Y0WOmg5l3ddYVmxobp2m5E80fzg6khQ5v1coXRcHBUkY+dJESmkz+snCJ/u+QBpQj9LuaPjwb23PtfKIawWicYvVwCgpsAUjCMO6tLOoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JnG4W5tV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NBtwQbhc; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JnG4W5tV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NBtwQbhc"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674CXADT4129554
	for <linux-mmc@vger.kernel.org>; Tue, 4 Aug 2026 13:43:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uCJEjgy+cY89Lh+egithkvnNSKQBvF9hR3n7hs2h3IY=; b=JnG4W5tVlI/NdyP0
	AcdE+LIExewUqurdcKRMRjaKcfeyaeMPFNRcHLJAC1sgc4Uv97OE209lhhBKX0yA
	9wSYFhMMXcrUVY3PqKOsjFhN5xej7+gX0daS4VTqVLutOzggWzVtXLpekQM8sVic
	UJPm4/jYvevai6bTVvRVNP/erUeQERHmQYtpKmABOzYuMTm74w0wgqm9WfpCdGeX
	GjTeELTIzwl+STiebe8QXLdZ8/FuveHvHmDHHTBxG0APjvR3qJv+PgAB5J3xU6QK
	xC0bey9/77Z7Cu+yfrSxKew6tGRBayIQxZTOGiIuoZK05cMqUp+5TYx4yj6a3/w4
	3+aM2w==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fug6589xs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 04 Aug 2026 13:43:27 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8f0f45415cfso53766486d6.2
        for <linux-mmc@vger.kernel.org>; Tue, 04 Aug 2026 06:43:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785851006; cv=none;
        d=google.com; s=arc-20260327;
        b=TywvR11XdV+eDLPX2CiTnDVE5QMG4JPa9IDP+8OXmEBfVXZZYoOEbF0SRnUe7wh2BN
         Hg8ta/LIBd5/a7q3APyVmTNv95SqSbqY4l0BFoYBQoUWUW8FjE+Ghg2QzESCACT0CPdW
         Wn5iqVcvT7RhARoc6nEyo1RX7OfdRxFXr9cezB3G18O4l1b+/b5RO2NCbthaVEI+C7WK
         F46rX5GxaChSKIkAwfCcgQHkt75SOJK7iNj0yN+R780Fqx8+YT9MUxgmkQasq+jeoIsl
         ZZ18UTaLYo8alKk7PKgH9v0s/mgNJL1FJACBOdmrDPvntnnlrI/i5z0PbWhDLITC77BR
         drMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uCJEjgy+cY89Lh+egithkvnNSKQBvF9hR3n7hs2h3IY=;
        fh=0m7NyUheHbHR/jvuvFG/FV3rBieyAvKQxWgUtCK14BE=;
        b=rKZL9YJ/haThxME6a6e1teIwWuDjDxRLCN+8giny0Lv1lcQ6+pivwF2X9BsMYhsvXj
         wZvbjKjza49xAFRXGJhIa1ySiSygSNlwKbGHKj1zgs3YV896Xb/RsGXYcavb5Pa7EDSv
         adIOO8p95RLN98PxwKoV9GcX2Fb3BRZVqp/UFGzw5NPBCnOu3fDfT1H1AW5JJc/WGJjj
         1c/mtQ3/azu2ya8kDZXkiCSd6l95Yja5Pr2hABe8AyslAC1mn5eNqLduy3TWdvvYFkok
         dX7S20eXpOsW8hXwGReIG+qGGEFZnz2/WMloAXHCC6YDFCPnzop+3kSwO0iVGRlul8cq
         j4NA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785851006; x=1786455806; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uCJEjgy+cY89Lh+egithkvnNSKQBvF9hR3n7hs2h3IY=;
        b=NBtwQbhceeJf9DWnFAB72W5ez/n/g1hzgG37E5ftMSYqboikeJhHkGKeexAbogvQ4a
         V1fjSANLNwtQZ5sfS8SlVe5dBjjmczs/GBM3yWqVKYaJ9TjOdMu4xS+XCSP1ZD8gBl5x
         EmFgPyBjbekeUXsBQY74+QGgLRQbNzYGqBQ4hFZtLBnjrexc9XH7MqEnPp0b7KeObfwb
         hp3AdMvHJtvrtweuew5yd0/x6YFReeAJk1kGPJU5aNEMpDBqMTsyGslnIqzKgq08KIkf
         hWUdp166d3yblTdvFCSqchCBWNlgk42JhC03WTOMox1BDiqSRmVMPReHFqOGhcZzGxI8
         Rp6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785851006; x=1786455806;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uCJEjgy+cY89Lh+egithkvnNSKQBvF9hR3n7hs2h3IY=;
        b=rAvCzUDBQVawWGwUwRS0bsa9sk2fIBrwKCiQqnhlNtuvRGbGCvMtrmP3QK0L84V6Pd
         FHMlMQBc5zXCjDudVW338qfI3b4HqDfGEW/M8FvSN1fAI7UK/dm60egQDaShpnADuz34
         UdYnlh/bXVjyc7r58f5jRRtRHHnvnGtt+vfzSP9ElMwwilFh89+/voJbukw3itZ64luM
         nR/ymhZT2XaiG+Cx228+G8u77F2m8hF4pmgzenpucJUjJrKldm4H1ZWHG6GSY6Rv4J1H
         KphW5guVqiFPqlnKp5I14EHnM8vEj8jEw9ivQilAFKFmv0/J5dgGE427+KYeW+oC4YuI
         yTjQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp8nUpgy3z7g6tdOzml/1P88EY+QEPDchwf63IMo6EgQ0DBvqW6ByqvkDpItI2kw30hNVZSkjMIieU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3VrL8/EXPvAMmxKyJtVLqtR3sUyh0ihnOd0eI+ynDHMYtY2K8
	FESibpIpItbr1Tgbc4HTxcwVMJp58bzDO7gevZ2HeACSisExjkcSgOV2J+qrD2K/AdUHC6Qanik
	R+isioDVFXBKtLiaioXSUAzcUGh3SY9qvs/+04jKl+TsOEFrDdXuFwvAFXOfVLBt68g+Zab99x/
	/jyXlz8JDzPjc3/CheCV45Ick6ZgBnWJFllLRdiSpdA5w9+w==
X-Gm-Gg: AR+sD10aAbiqDDq2VolAHa9/iFIPtII+wb2VaCrvEEtDW5GI5/JcWtxid0b6G7EMDxe
	jGP/EYFLJdb1d2zRVxVADxo/rnmeZKy/juyrJeJxkNOcBCo7bCCwfUZ5gNGfdRS74qRfeWxtXrw
	i74Bs+hNO0QDLLI7m2RKZBHnldlXvk5BGe8mJrQA2qUxyVqMmTAZLbd0nKIA==
X-Received: by 2002:a05:6214:5bc5:b0:907:5aa8:ceb2 with SMTP id 6a1803df08f44-9084960f1admr321435476d6.18.1785851006517;
        Tue, 04 Aug 2026 06:43:26 -0700 (PDT)
X-Received: by 2002:a05:6214:5bc5:b0:907:5aa8:ceb2 with SMTP id
 6a1803df08f44-9084960f1admr321434826d6.18.1785851006018; Tue, 04 Aug 2026
 06:43:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <94dac731cadea4732725a83bbbe1d8fe47636694.1785807411.git.xiaopei01@kylinos.cn>
In-Reply-To: <94dac731cadea4732725a83bbbe1d8fe47636694.1785807411.git.xiaopei01@kylinos.cn>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Tue, 4 Aug 2026 15:43:15 +0200
X-Gm-Features: AUfX_myfnb90SUIixbHDeL3-hYflYE23wAYE0a-5kx-aFR3MVvWlGgj39HYYYAk
Message-ID: <CAPx+jO-nfhVA2UiPxYJ5A3gzdwBmjgo4oodMhqMW0xFfPCrdTw@mail.gmail.com>
Subject: Re: [PATCH] mmc: via-sdmmc: Fix use-after-free in via_sd_remove due
 to race condition
To: Pei Xiao <xiaopei01@kylinos.cn>
Cc: ulfh@kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: PxAhTSl3401OYgIxyiwCn5wpl5BTcrHe
X-Authority-Analysis: v=2.4 cv=fcydDUQF c=1 sm=1 tr=0 ts=6a71ec7f cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=g3Nt3TD__WDKnRpXwLwA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDExMCBTYWx0ZWRfX7qNM+F0vysXm
 U8jaCdgqs0VzV/RSKybLmZA+3sNVI2FxdXBSVkUEtQuPH08YhP+70qJZXOoLlmRQlBD5fOxl0jG
 lvrxGjx8ZuRp5ZissPXXYCIpcMnh9YA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDExMCBTYWx0ZWRfX6owaaaZdesLM
 DDMO3MHY97HGS1dx8Ll+Og2NGpac4gmyr1Q8U90M7kAnJGLPu+oT27qDOcXHUH8cZYV7xLmNFBi
 2cBwGqeY9gtrNEy1BS0v/A9TWxsR1PLcDrkFUBrGSAPvNqQkIdcA0ecN60FBHomaUtNIecAjoLS
 x3b77EThsVqC5Tks5BaqPuyTr5f7UPfDCNui9q7c6or9li/XDx4whoVpDtIXneHrmRJWN/qQwrn
 MUYqsQ2SGiOEJm9tKPXT8KMyNczw2hBPHRGyzqBUByrjdyZmsnYCvvkQjAjk0QcG7QlM9AoE83R
 iOr7NMTw8trmWwLTaaKMzUf2+A2UIQhf3/xeQpUW+PYAQRjZ4kodrv1lAeTHpGtzUIaqZSYxRI7
 VZG49FF5L4ZaBifTAiwDIK/yZ4Up1WThVXdDZdcPhwntXgSG/PTVlsKELY+SgurO4hWuHZChTqJ
 8X/3WQQwEsWtm8RWsHg==
X-Proofpoint-GUID: PxAhTSl3401OYgIxyiwCn5wpl5BTcrHe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0 adultscore=0
 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040110

On Tue, Aug 4, 2026 at 3:40=E2=80=AFAM Pei Xiao <xiaopei01@kylinos.cn> wrot=
e:
>
> In via_init_mmc_host, &sdhost->carddet_work is bound with
> via_sdc_card_detect, and via_sdc_isr can schedule this work on
> system_wq when it handles a card insertion/removal interrupt.
>
> If we remove the device, via_sd_remove makes cleanup and the memory
> allocated for sdhost with devm_mmc_alloc_host() is released after the
> remove callback returns, while the work mentioned above may still be
> pending or running. The sequence of operations that may lead to a UAF
> bug is as follows:
>
> CPU0                                      CPU1
>
>                                           | via_sdc_isr
>                                           | schedule_work(&sdhost->cardde=
t_work)
> via_sd_remove                             |
> mmc_remove_host(sdhost->mmc)              |
> free_irq(pcidev->irq, sdhost)             |
> timer_delete_sync(&sdhost->timer)         |
> cancel_work_sync(&sdhost->finish_bh_work) |
>                                           | via_sdc_card_detect
>                                           | // use sdhost
> // devm resources released after          |
> // remove returns, sdhost is freed        |
>                                           | // use sdhost (use-after-free=
)
>
> Fix it by canceling the work after the IRQ handler that can schedule
> it has been stopped, and before proceeding with the remaining cleanup
> in via_sd_remove.
>
> Fixes: f0bf7f61b840 ("mmc: Add new via-sdmmc host controller driver")
> Assisted-by: Codex:deepseek-v4-flash
> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>

I already have a patch for this in my tree, so this isn't needed. Thanks an=
yway!

Future wise, please make sure to base your patches again on my next
branch in my mmc tree.

Kind regards
Uffe




> ---
>  drivers/mmc/host/via-sdmmc.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mmc/host/via-sdmmc.c b/drivers/mmc/host/via-sdmmc.c
> index 8c049f8355cd..be90fc767c74 100644
> --- a/drivers/mmc/host/via-sdmmc.c
> +++ b/drivers/mmc/host/via-sdmmc.c
> @@ -1199,6 +1199,8 @@ static void via_sd_remove(struct pci_dev *pcidev)
>
>         free_irq(pcidev->irq, sdhost);
>
> +       cancel_work_sync(&sdhost->carddet_work);
> +
>         timer_delete_sync(&sdhost->timer);
>
>         cancel_work_sync(&sdhost->finish_bh_work);
> --
> 2.25.1
>

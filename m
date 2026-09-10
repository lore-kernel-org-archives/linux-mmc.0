Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4965C47D952
	for <linux-mmc@vger.kernel.org>; Thu, 10 Sep 2026 13:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789045260; cv=pass; b=pE1KVgKU3xUI2h7hFAZg1QGx9mfk+J7HRChky3v5hoVFufUTBOhr7NcB2TVr8I5Yxk5Knn1LmD1bjPO0hNuhj1chnmd3pCc+JlLkMgdQggtbEwqkHToKnhMbUplq1RuYKhzPNQ9UyyMZAIFB3NAIOcJ+bXoXw5pqZkbk5FBhGZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789045260; c=relaxed/simple;
	bh=NXUxQk7Ksy0lqFKZ/eFB7Gaj7G6butbDvH5VMceVmw8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sd+nmbNbB5wNGN96uT1ak8WYvNkeQVOHW9dL2/MnRz5+oUuhqY23oAetqgNSh58pgIuHWzs8MFUbIYyxLgqo92FfJpyRdDfrA+fP7YT52+H37i6Xs8Cwz3k/DX4uJeH8ZNeh/w+suFsMTBXnuELk7XU/HY5aIp8ZmRxEmhGLJcg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GxYLJgsY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OTXfSpdZ; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GxYLJgsY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OTXfSpdZ"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68AC7nLh1732808
	for <linux-mmc@vger.kernel.org>; Thu, 10 Sep 2026 13:00:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	c7iCVDBT9IIOGDA3clTRXrsTi9McQrVLIhvfbpXQ+Sg=; b=GxYLJgsYjgWyzCI2
	QcuubqvIGDgqdIx4CCxwDI1y5pSwfE+7uwz3MqrQvkkfMHUobpueTOGRnT95Wmrl
	uyUkzNdpL/+f+9Vo7V6XBfQVzYBEqWjRnltya32G4yAtFT/SloJnY3seUnhaG83E
	qOZFkJVBhlUj9fevl0y3Rb4Xkyq2rNvtDhTPFYetkaVp03ONapSbdx9e9BieW5C8
	1vjguqf8G4gSji8yxVHHNo1J0uucbZxuYH5tHpDRMt0wTh+7XgJ7RX2Kgp5K7b2J
	qVcikPcIEXe1qOFCc8lZ80Zs7huiwRM3+L1/IpK6EACoUKQB6gTev1yWBg0jiQw7
	WXbhNQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkcydkvvb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 10 Sep 2026 13:00:57 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc39363cc88so7325954a12.0
        for <linux-mmc@vger.kernel.org>; Thu, 10 Sep 2026 06:00:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789045257; cv=none;
        d=google.com; s=arc-20260327;
        b=LrBTA0v3RjBFCSV6LeQPE93xFEokJuj3E9EIe4uqG31ZzgezA8QEKBSzm7upbRW0BT
         67GuMFJxvItA4y1dcur62rxCNiMY2diIjg+zjElrUb/Rr7Lhvwl86LsXUQ1pWc53kfLa
         uSw2AE21mPD/ArrXzukJPD/Sxij4x4W/B4MUfsi2r4KNfo/LVFwj/Nwo8FPppnACIJjP
         YZ6hdW56cfEHtTBl2fvs8nD1rmHRKpU+QHwEV+g+rCe9bjDZdnnQ2bUc1+DvO3MRsRTZ
         xg9vJX9AWMqdtOOVVdBoTnBdFYGITxsJJVHPC+DaPCOcKgBwp7Plg4qErtIuCCPsE+HY
         FaIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=c7iCVDBT9IIOGDA3clTRXrsTi9McQrVLIhvfbpXQ+Sg=;
        fh=AUQJGTVi2xSaRPj8cbQLDUlqD1/Nff1jJZaVfH61lY4=;
        b=LvOO0UTcCooaV/v4O88acMq8mCWimfY+qpoJLq4n+nGwcBLo/uhR9qLTFv1yeHMQwQ
         jbuvNZ+YKh7jEvOhi1i8w9jWV+9+MaYlPcUlxdLSJ4DBMGhY7ogyI5uweg6oZkNS7+0c
         3MprhgjSvnhd2D6yzBcsRPJpaWZBNQGf0YVktY9+Cn3p+XFLFfEGniKtOJ+DP06Km903
         TQCvAbytUi8gzrMWmdoSw/KS7q8K2u+j1bcBg7w6ztqPGgwSGMt8NiprpAhb3F/s27dL
         oNnNbZmaCTzUw7QF9/UezmrSuhCC8af1cNm7IAn7Vogv3QLyCyKc51AESq6cK4eI4Df9
         SaTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789045257; x=1789650057; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=c7iCVDBT9IIOGDA3clTRXrsTi9McQrVLIhvfbpXQ+Sg=;
        b=OTXfSpdZjAfuGSkqsTdshprHXM0s4t9ZNrr2eUXHLL0zThFWpsBgCMu0qjKeB2UZxn
         YI5Rqvvw2EIr/f3zuEpol/i5qAQlSkkJCxInVeiR28DaV/zpS0q4U2NDeWsfLGUetnz1
         sLy8GhnT+8puLwwjo3XARkJIWLKADP90G6POiCiLHNJmaCXiRAf4iIqYG//lGTWLr1Hy
         U8saljizsiiZ1HBbtNkg/P4wrL/AeOHHwg42dZRSyS+o9UNEq1JHXWpQJmFELztOFf6A
         AcnjIZL20NCAvxAVKIfcq0W4JLw5Yo3HX2/ZJPCi1/Hm45axFxEbYFNbWJOnH7jpYnSH
         nZ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789045257; x=1789650057;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c7iCVDBT9IIOGDA3clTRXrsTi9McQrVLIhvfbpXQ+Sg=;
        b=AeVYeOCedj9dgjk88tg0eiFeRf+d0hgXz6m/qjIENJSgtbyrzKivn8o81/BfeixDk4
         EOo4kmIQLFbcDvd91KQKnx+/vmP8dU31a1uMTqm+YCfZCqXJmk+U9L6cdqDzYADeAlXJ
         RVFYQt78GAekhfTh5JOG2Z1Jbrto3n/lwWGeDOB9am/OmS3vzHd6HPn8tPJp6nAuyl3c
         yP/DRfnJwLXQmPSjNSJPi4OG1Ns1vTvF87UnOrogyZcDEer/S21fdNJsWANp47fJGGuu
         dee36ypvtVISYZwFHmwFZ2kqJLo1jU84eY8GXoxgQDNL9rbvLlZUlrSlPMBxoNe8coyS
         3k/Q==
X-Forwarded-Encrypted: i=1; AKwUvByWWuMAHXPthDBOVUTA+aXy3MVn8j5xGRo3btOclHBnaTDSZgTPWwoKAAKB4AT1+EZLrq5qzyXAmiU=@vger.kernel.org
X-Gm-Message-State: AFuF++mTSlDh3/OyzV1YXth/uOm21hu8gxpFMJJIRgiPboUi9Ga5UaLr
	E0AsWtHn38nrue7A6wlTMwUn2Om9VtW/4IkfOqAFjhGXhUXEgpw2BDFrh8thQQHUmIj+OhAhZDF
	aFju65nEPJ3swuUOzNgh+JIifEC6EaiYMa6kiKyeuu2xD46WKxOs+ROre4o0yntMY6gmxm8IJMl
	/slPlCcXq0l865F3BPK+fJd7RiOUtPa4EOndb3Aw==
X-Gm-Gg: AYBFou1dVGas7jctvc4JWWzQ5SeI0sXU1ZdPfdwOSd8r8/JBLalKc/Ymw9X+WZmPH65
	eKSsVfOP+X8JwCFwZNz93fX/kqL/RDXqcK/hOFbfL/eaYILr2AP1q1C0MLzDlVuMv7FzVi5Xo4M
	rxfd4YLzwhioNcZ+IfKB6b5Scl0rmPR2Ii5B0ze53bXBOVY6BLGUGSKQVYRg==
X-Received: by 2002:a17:902:da8e:b0:2da:eb8f:b4e4 with SMTP id d9443c01a7336-2db124c35f8mr558469535ad.7.1789045239168;
        Thu, 10 Sep 2026 06:00:39 -0700 (PDT)
X-Received: by 2002:a17:902:da8e:b0:2da:eb8f:b4e4 with SMTP id
 d9443c01a7336-2db124c35f8mr558440465ad.7.1789045226507; Thu, 10 Sep 2026
 06:00:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260827091436.1339716-1-xiaojie.li2@unisoc.com>
In-Reply-To: <20260827091436.1339716-1-xiaojie.li2@unisoc.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Thu, 10 Sep 2026 15:00:15 +0200
X-Gm-Features: AcwNN1XNQ4fZJTTzmnpDFbrWjbGQV9imP4SmqvlRa9AkoN1LbCwNPREdmY8YGvM
Message-ID: <CAPx+jO8Lc3iNNBVjBB33aJYUfdr2EJqpL8mS8weKnZcBaDf0vA@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Modify the CMD1 transmission interval
To: Xiaojie Li <xiaojie.li2@unisoc.com>
Cc: Ulf Hansson <ulfh@kernel.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Wenchao.Chen@unisoc.com,
        Rain.Zhang@unisoc.com, Yuelin.Tang@unisoc.com, cixi.geng@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDE1NSBTYWx0ZWRfX7J1odS+0Gsdh
 /Whb9WDcB//ZnvmfLb3MSvg55nh0mSwCwdPtDZHVVEYMs148WsUaaGfPgy8h/MGH/Fk9aik6uwj
 RmYAY/c23d2OUMOi+A+yWMyyvSIoAOA=
X-Authority-Analysis: v=2.4 cv=UJNIjyfy c=1 sm=1 tr=0 ts=6aa2aa09 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=icsG72s9AAAA:8 a=7Y93FPtxMF3Rj5v4aZMA:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22 a=T89tl0cgrjxRNoSN2Dv0:22
X-Proofpoint-GUID: NdIjEqO6z9s8D2rBHxgVwkLtIos2jfjh
X-Proofpoint-ORIG-GUID: NdIjEqO6z9s8D2rBHxgVwkLtIos2jfjh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDE1NSBTYWx0ZWRfX0gj6IetstnPK
 Jjo84f5DfX9PYYdnYLCKI0XcsgANQ+LD1WK7/sRvHQsL24wwOjVcbl3/HmM9wxHGSHpz9F1PyvL
 sLcWD1Mmyj0s1xOOTl3WtoV757Bsx1Q3SwuHSDRQAhViLKxHAn46ZX46kIjx0mDJ9gZM8TJazRC
 Q0RhVQQbHcVlRiHbM8FGIuiU1XqrkDLuGvhS8tZGomDJUOKT6z1FgUpU5yyJMR1DvgYj+pujTWE
 JbG6qtkt+2WO/lxRoBEdu4uL6Sg0/AMaDNCuxGrVay2vrmff6u3MMk9gzqAvilz+iTti7qXfyJr
 6KmPmWHEafMSFtpJCKEEIc32OlQzOqXqqB0IU8olfJxWVEIWzpmCwr6enLZcoYjI9Kv6G4hjAgu
 iSYmuG99zzJ8HJLyKFsJXA8yTxW0V1cbQAhCpPf4bw+cgkT2KFXxmNTi+RpLdn0M+opZB614jYU
 8fSa2bUTG31HRRDyKlw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_04,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100155

On Thu, Aug 27, 2026 at 11:15=E2=80=AFAM Xiaojie Li <xiaojie.li2@unisoc.com=
> wrote:
>
> The current code's maximum udelay value is set to
> 64ms. Since it uses usleep_range(udelay, udelay*2),
> this results in a maximum wait time of 128ms between
> two consecutive CMD1 commands. For lower-performance eMMC chips,
> local testing shows that compared to the old code which used
> mmc_delay(10), the total time required to wait for the busy
> bit in the CMD1 response to change has increased by approximately
> 300ms, negatively impacting the overall eMMC initialization time.

Okay, that's not good.

>
> Although the current code sends the CMD1 command fewer times than
> the old version, the total waiting time is significantly longer.
> To address this, it's proposed to modify the CMD1 sending interval
> to follow a pattern like 4ms, 6ms, 8ms, 10ms, 10ms, etc., effectively
> capping the longest single wait at 10ms. Local testing confirms that
> this approach can bring the total time waiting for the busy state
> change very close to the performance level of the old code.

The code you refer to has been changed and fixed several times. We
need to be careful to not break support for some other cards. Please
have a look at the below commit for better understanding.

e949dee3625e ("mmc: core: Fix busy polling for MMC_SEND_OP_COND again")
1760fdb6fe9f ("mmc: core: Restore (almost) the busy polling for
MMC_SEND_OP_COND")
76bfc7ccc2fa ("mmc: core: adjust polling interval for CMD1")

That said, let's try to figure out how to improve this. See some more
comments below.

>
> The eMMC chip used for testing: manfid=3D 0x00009b, name=3D Y0S128, mdt=
=3D 2022-10
> The eMMC part number is: YMEC8B0TE2A2C3
>
> Signed-off-by: Xiaojie Li <xiaojie.li2@unisoc.com>
> ---
>  drivers/mmc/core/mmc_ops.c | 85 ++++++++++++++++----------------------
>  1 file changed, 36 insertions(+), 49 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index a952cc8265af..3076666cf2ca 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -189,64 +189,51 @@ int mmc_go_idle(struct mmc_host *host)
>         return err;
>  }
>
> -static int __mmc_send_op_cond_cb(void *cb_data, bool *busy)
> -{
> -       struct mmc_op_cond_busy_data *data =3D cb_data;
> -       struct mmc_host *host =3D data->host;
> -       struct mmc_command *cmd =3D data->cmd;
> -       u32 ocr =3D data->ocr;
> -       int err =3D 0;
> -
> -       err =3D mmc_wait_for_cmd(host, cmd, 0);
> -       if (err)
> -               return err;
> -
> -       if (mmc_host_is_spi(host)) {
> -               if (!(cmd->resp[0] & R1_SPI_IDLE)) {
> -                       *busy =3D false;
> -                       return 0;
> -               }
> -       } else {
> -               if (cmd->resp[0] & MMC_CARD_BUSY) {
> -                       *busy =3D false;
> -                       return 0;
> -               }
> -       }
> -
> -       *busy =3D true;
> -
> -       /*
> -        * According to eMMC specification v5.1 section 6.4.3, we
> -        * should issue CMD1 repeatedly in the idle state until
> -        * the eMMC is ready. Otherwise some eMMC devices seem to enter
> -        * the inactive mode after mmc_init_card() issued CMD0 when
> -        * the eMMC device is busy.
> -        */
> -       if (!ocr && !mmc_host_is_spi(host))
> -               cmd->arg =3D cmd->resp[0] | BIT(30);
> -
> -       return 0;
> -}
> -
>  int mmc_send_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr)
>  {
>         struct mmc_command cmd =3D {};
> +       unsigned int udelay =3D MMC_OP_COND_PERIOD_US;
> +       unsigned int udelay_max =3D 10000;
> +       unsigned long timeout =3D jiffies + msecs_to_jiffies(MMC_OP_COND_=
TIMEOUT_MS) + 1;
>         int err =3D 0;
> -       struct mmc_op_cond_busy_data cb_data =3D {
> -               .host =3D host,
> -               .ocr =3D ocr,
> -               .cmd =3D &cmd
> -       };
>
>         cmd.opcode =3D MMC_SEND_OP_COND;
>         cmd.arg =3D mmc_host_is_spi(host) ? 0 : ocr;
>         cmd.flags =3D MMC_RSP_SPI_R1 | MMC_RSP_R3 | MMC_CMD_BCR;
>
> -       err =3D __mmc_poll_for_busy(host, MMC_OP_COND_PERIOD_US,
> -                                 MMC_OP_COND_TIMEOUT_MS,
> -                                 &__mmc_send_op_cond_cb, &cb_data);
> -       if (err)
> -               return err;
> +       while (!time_after(jiffies, timeout)) {
> +               err =3D mmc_wait_for_cmd(host, &cmd, 0);
> +               if (err)
> +                       break;
> +
> +               if (mmc_host_is_spi(host)) {
> +                       if (!(cmd.resp[0] & R1_SPI_IDLE))
> +                               break;
> +               } else {
> +                       if (cmd.resp[0] & MMC_CARD_BUSY)
> +                               break;
> +               }
> +
> +               /*
> +                * According to eMMC specification v5.1 section 6.4.3, we
> +                * should issue CMD1 repeatedly in the idle state until
> +                * the eMMC is ready. Otherwise some eMMC devices seem to=
 enter
> +                * the inactive mode after mmc_init_card() issued CMD0 wh=
en
> +                * the eMMC device is busy.
> +                */
> +               if (!ocr && !mmc_host_is_spi(host))
> +                       cmd.arg =3D cmd.resp[0] | BIT(30);
> +
> +               usleep_range(udelay, udelay + 1000);
> +
> +               if (udelay < udelay_max)
> +                       udelay +=3D 2000;
> +               else
> +                       udelay =3D udelay_max;
> +       }
> +
> +       if (time_after(jiffies, timeout))
> +               err =3D -ETIMEDOUT;

We really need to avoid open coding of busy loops like this, as it
becomes a nightmare to maintain for us.

We have moved to use __mmc_poll_for_busy() for this reason, so let's
instead try to extend it to fit better for MMC_SEND_OP_COND.

I guess the most simple approach would be to add another parameter to
__mmc_poll_for_busy(), to allow us to specify a maximum polling
period. Can you please explore that approach instead?

>
>         if (rocr && !mmc_host_is_spi(host))
>                 *rocr =3D cmd.resp[0];
> --
> 2.34.1
>

Kind regards
Uffe

Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97414FC8C4
	for <linux-mmc@vger.kernel.org>; Tue, 29 Sep 2026 10:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790677516; cv=pass; b=LGNKy5ifw8BSAjzLfxpcHMEyH1D8DYcs+aYhgacezr3oCKl+GzSByDDuINJpSRoG4m6CwsRXlewxO5d4zwwZOH1xF+Id5pDm1+fHWikTRunPt6OkIEYxkR7QQNHMuDfAntTzsUl1CVT4bTpz0PzV7QzErjtsDOtWhn7deIps2yE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790677516; c=relaxed/simple;
	bh=xgfkl4zyeC8RuLq+GN4w/BY563W6yJYYNI4/dPhH/BQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q2MLWUColKU99qbPTFAj2bNbYc8JsDqEJYayUmO6Ka7XDkItxR++M5QffA9UfdsN//Ui8bc1LCMeGyro0yyDCtc52IUpbBGNf1/qIb2EhjMPyX7WU1vv3kjRo/xakRN8OJafuTUo5Hmn5xWqfRJBYIyFqkJTC+ulCwjqoSRmJq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LjblXC5W; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=a1LaOrfh; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LjblXC5W";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="a1LaOrfh"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68T8XRcx1004680
	for <linux-mmc@vger.kernel.org>; Tue, 29 Sep 2026 10:25:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	s4iTwSNVL2vSXyi0y8I31DfIwsKabNOEbE1ug4XUhBI=; b=LjblXC5Wq5spxTll
	iV1cW0RqiNpWKU5ovTt1P4wkg4mmFgutgPxDhgPsNlWjxzipu6M0Zn+EqVXw3XP9
	G1pztpNf8sRjoh3X72BkyrZFBzXZ5QLlCNYQpL/ABGILhUner7Q1p23AlV8P3d7t
	XGDSeLTYnuoZSq/qOO1jozs81YJz26xsBakkz7gV/DQy31UqHl2cjCVM8r2aBuX+
	8dx+92idnJnKH2Z6SN582mjqzMvsC8BTrIzFEG70vcYXSjIoIieoXp7+L/StU6AP
	eQgf91qGhu64FlGPE5cZZTyaJEvk/segIU220R74zPst3eg0QKfQCKFWBBWcLGEt
	L1lbFw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h09x4rehq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 29 Sep 2026 10:25:04 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-39aee9b4cf2so6770055a91.0
        for <linux-mmc@vger.kernel.org>; Tue, 29 Sep 2026 03:25:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790677504; cv=none;
        d=google.com; s=arc-20260327;
        b=bzJDsfce423B8TTpM1b/v3Tt2rBB4LZEVGa6kDPcEEUG0cdgYDQ5PfHyk2n7OMBpq0
         eExlRsrRV5/Njz+oPsZw+HshkeZDjz/L0p/I3Sb8A4ToI5O6vaw757aSI23kzVAx4Cav
         wcKc4EyZifaVJFlCcuzYa80Ei9m4MDvdpIBLSdr2P/3fcUvE79QCm5byAJ9AjmXn8hI+
         hrjFGfFiqCwBO6QWt8zIaA5OcNbmBSeubKT8RF2GGVmBWAz7HiZmkIgegBYK5WeUwIag
         3USEHhzVF5j5ZVrXgi/kDUWShA8HeayK5cC51vy0BuzQeiwOS+qYk37l+Wz9DT5cfFTb
         qPww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=s4iTwSNVL2vSXyi0y8I31DfIwsKabNOEbE1ug4XUhBI=;
        fh=cOYSWv+wxZZ1iKqnWXzWIxCGNDZE4u2WzhsOacKSltA=;
        b=b3VT+/MvqYQ1sKGyBQoopTlsvHaHyg7KOqREcmyNPEC5PmU0NbYMWl2dGgyQNwPWrZ
         xIM18RSyzyTMr2XelrHQkL0ChGZGCPYfi4gtF9Fd92zdRZ902tAh1gedi+tcuuq63VeT
         rzy4jnKGooCKNL61U8MJYYqiNBe3pKDQeJSKmdI2WeHiIZ5UPFw6meqXIbjjhjtxiZ3A
         YUMf9jvTWuNGv4k5b97PRbIMwBI5ky9/GhG2muncpBTalpB/aWAwhTETTngAyBEZ+T+c
         iQEXZn+BxB0wlNtfiBptJs/nCZCh4jEX8B2gV4tYDjY5URwgMqZay6383379t20RFsvO
         LfbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790677504; x=1791282304; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=s4iTwSNVL2vSXyi0y8I31DfIwsKabNOEbE1ug4XUhBI=;
        b=a1LaOrfhavWHzi8VXU804Mb4UTLS0VKwQFa+BW9AiuFLX3NzjjXMlRCIBkkju2w01X
         CYnZCMkY6HK0DjSaazrA8W3JH7TAsRAGyNVHsgkFGgErisj7EEf8ervcmErEmmAmMo0A
         O+QIfB6CqHhxjRSFQIxkUIff83UqD+GxYD20rBcnr8KhhvUfS35fvLsefUJ6OAxXyTiR
         rdE1/6xSGD7UGktuY01YsNtqgHEgqxS977GTLEdgW45l8m7/Nv6+scf6U8WMDWznF7W/
         gt0vVtssGwoBjMynkMtNqhGMzy6hc5iupvmKY/Y39TzCCZmJoSpV8PaCcKqzw2XPSU1q
         J1jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790677504; x=1791282304;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s4iTwSNVL2vSXyi0y8I31DfIwsKabNOEbE1ug4XUhBI=;
        b=qOyVXvOPfwjTjWhIO8d3cmSEqJ8JsUWG01fcuKF/R751tSd13EcM8cav+DoYDo0y4r
         h1SEESvnLyJu+fW1+BD38VBATJHUOUhsfu6bDKNooh83NH85MDguikh6s5AgqaiRboEm
         hzpqxlRcB1sIsbtrdJ2FIKgMovScF1xFCxvs8niJhiFbjmdqwzrFOZc9RZDcyktLrG1J
         90UiDHgfeQsJ6e0mITO3Uw0kIxH1bNu27yLABdYOqRzUx7bw3GW9coW/XtJOLUDcCPcd
         NONppbFCKOW9yx1lTuTzNMDEfk/Sj1vFXzJBhMVI8EPG8kovohZnAmpQXQ2MObTtcgSS
         zCfw==
X-Forwarded-Encrypted: i=1; AKwUvBymMo/c2iX4LR+s5qADvvgTUEJF9+A9Yo7ON6GhIyBWrKRyUOvsBtkeIT6i4El22bjWqmcYBob94s0=@vger.kernel.org
X-Gm-Message-State: AFq9FYITmqfwzK/l76as2Ly7hfH+lcjbwAbeU1M/594m7U9BenCN2AQA
	LXUz3N5FG86FRm7m+YSekxOpD9yOXc1SA1Sa+ZTOrDzDHTRjFtuVpRAZqbm9mS3mkrk88QdISZS
	gRoCSTV3L5zKTNi2RbIZ5bCmv2cY4uHTQa3cVNNYzrE/grkMyFv85Epk7TxiCD+k5RwN/lTRIu2
	QCcqiXTM+6jdgbWF8vsth7re4e1D6+X46ROV+pBA==
X-Gm-Gg: AYBFou17D/GSe8X1I4VjP6+lehahOe22Xi0n+uKMmMl2HXFYT798hVRc3NQRWT4RJa3
	PIxAbMx2vhF45avchxJww6fKGUK145vXNnK8Wn/OZYAjbX+SZUv1wxjqmTe9wLJ0+8m8W7kMe6P
	PXNLikm+8nbrPmn4jiWov7iJvSrp763MqlhnF3UmKnWNm5gHc6U6OiSRX0Dw==
X-Received: by 2002:a17:90b:4c42:b0:39e:6c68:c787 with SMTP id 98e67ed59e1d1-3a098e5897amr14850065a91.61.1790677504032;
        Tue, 29 Sep 2026 03:25:04 -0700 (PDT)
X-Received: by 2002:a17:90b:4c42:b0:39e:6c68:c787 with SMTP id
 98e67ed59e1d1-3a098e5897amr14850040a91.61.1790677503429; Tue, 29 Sep 2026
 03:25:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260919100408.113979-1-ngocthang2710.1999@gmail.com>
In-Reply-To: <20260919100408.113979-1-ngocthang2710.1999@gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 12:24:51 +0200
X-Gm-Features: AclHuK-ioFY03K2yBE6RpDgYHkyETT-slCthEuTAZuN6jBDlBpFjIurlN2EUv9Q
Message-ID: <CAPx+jO-JBBLNCUrnB0UaMSPu7ajwsrEQMPJ1SfH2PccCR5VnCA@mail.gmail.com>
Subject: Re: [PATCH] memstick: core: reclaim the request before freeing a
 timed-out card
To: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>, linux-mmc@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA0MSBTYWx0ZWRfX/4/XmTeNZoZb
 zbnkq7CG772ecQiq8p+4zLoly0vewgKvSrxtE9WMbH4FRof/++HiDk3V/TPX3k60WLGS4I3am0E
 jWIiUciK2B5TtPo2d8P1SjNrq93FWqQ=
X-Proofpoint-GUID: NDKa0Ky7Z4Ydo-PrEKjD8qqz5LsN1Yij
X-Authority-Analysis: v=2.4 cv=I5Hw19gg c=1 sm=1 tr=0 ts=6abb9200 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=edf1wS77AAAA:8 a=pGLkceISAAAA:8 a=hSkVLCK3AAAA:8
 a=j9i9EbPp1eeP6bqsIwMA:9 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22
X-Proofpoint-ORIG-GUID: NDKa0Ky7Z4Ydo-PrEKjD8qqz5LsN1Yij
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA0MSBTYWx0ZWRfX3WI4DZI5LPtw
 OYs0e3SEo11CPpjPI+82p/D3FGSXPBFWFtz2+OD5Ka+zqH1zUQ1Q8XZqP3CYvs4w05bBbPlV1S6
 BCdKJlG/8SOdRL6LItWIqhuE1zq6cvsxYjFudTpRSXrUl13aBFCx8yU7Jgj0kLK1aBxLqJEo/l+
 gqXCK0Z+iGiYBFg5gswriZXsY6eWd8BTEsEo8eb73YGoYDU1+8BeBMTl66fJt6agEWN+v34P94t
 AEJV/WN+B141LttkQ22sRJ1iIgfQP29apwDWcsEmmU6EFtjm6vt4zDJbPK3o4X+VuDyb4/liApT
 xiD+NENupYTKdofTN02xfJsQ1ttwIVMJgxtnyO788x5rYOVRcR7cWt4YqENnor2jJaxHA9WH35u
 Znplje+RFoBKHeX7ae6bOmIFCqFyw+C89Fav6irG66fS8izZfp7yBZqJCAFBOJqobKAAz7P5V7W
 8KsJ9DD1R2y/Kogh8ug==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290041

On Sat, Sep 19, 2026 at 12:06=E2=80=AFPM Nguyen Ngoc Thang
<ngocthang2710.1999@gmail.com> wrote:
>
> memstick_alloc_card() hands card->current_mrq to the host and waits 500 m=
s
> for it. If the host is still busy, the wait times out, the card is freed,
> but the host keeps its pointer to the freed request.
>
> rtsx_usb_ms hits this easily: its handle_req work can block in USB
> transfers for seconds. When it returns, it reads and writes the freed
> request, including the retry path in memstick_next_req():
>
>   BUG: KASAN: slab-use-after-free in rtsx_usb_ms_handle_req+0x17ff/0x1a00
>   Read of size 1 by task kworker/1:3
>   Workqueue: events rtsx_usb_ms_handle_req
>   Allocated by task 1656:
>    memstick_alloc_card
>    memstick_check
>   Freed by task 1656:
>    memstick_alloc_card
>    memstick_check
>
> Add an optional host->cancel() hook that stops the host from using the
> current request, and call it from a common wait helper on timeout, before
> the request's owner can go away. rtsx_usb_ms implements it by draining it=
s
> work item. The helper also covers memstick_set_rw_addr() and both waits i=
n
> memstick_alloc_card().
>
> Reported-by: syzbot+3ee5da0319ca17ef1f4e@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D3ee5da0319ca17ef1f4e
> Fixes: 99451dceeb5f ("memstick: Add realtek USB memstick host driver")
> Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
> ---
> Testing: no hardware. A raw-gadget emulation of an RTS5129 (0bda:0129) on
> dummy_hcd delays every bulk-IN reply by 550 ms (above the core's 500 ms w=
ait,
> below the driver's 600 ms USB timeout). On a KASAN kernel the unpatched t=
ree
> reproduces the report (same offset and alloc/free stacks); the patched tr=
ee
> takes the timeout+cancel path (~0.6 s) with no KASAN.
>
> I first considered a second unbounded wait_for_completion() instead of a =
hook,
> but rtsx_usb_ms_request() skips scheduling once host->eject is set and
> memstick_remove_host() flushes the workqueue, so that can deadlock.
>
> Known limit: cancel waits for the worker's remaining retries (a few secon=
ds
> with a device that never answers) while memstick_check() holds host->lock=
.
> Other hosts leave ->cancel NULL, so their behaviour is unchanged.
>
>  drivers/memstick/core/memstick.c    | 22 ++++++++++++++++------
>  drivers/memstick/host/rtsx_usb_ms.c |  8 ++++++++
>  include/linux/memstick.h            |  2 ++
>  3 files changed, 26 insertions(+), 6 deletions(-)

May I suggest that you split this into separate patches. For the core
and for the rtsx_usb driver. Other than that, this seems reasonable to
me.

In fact, we should probably have something similar for mmc, as
currently it's the mmc host driver responsibility to manage this
timeout itself.

Kind regards
Uffe

>
> diff --git a/drivers/memstick/core/memstick.c b/drivers/memstick/core/mem=
stick.c
> index e03989c4e99e..ea09a63286bb 100644
> --- a/drivers/memstick/core/memstick.c
> +++ b/drivers/memstick/core/memstick.c
> @@ -359,6 +359,20 @@ static int h_memstick_set_rw_addr(struct memstick_de=
v *card,
>         }
>  }
>
> +/* On timeout the host may still hold current_mrq; make it let go first.=
 */
> +static void memstick_wait_req(struct memstick_dev *card)
> +{
> +       struct memstick_host *host =3D card->host;
> +
> +       if (wait_for_completion_timeout(&card->mrq_complete,
> +                                       msecs_to_jiffies(500)))
> +               return;
> +
> +       if (host->cancel)
> +               host->cancel(host);
> +       card->current_mrq.error =3D -ETIMEDOUT;
> +}
> +
>  /**
>   * memstick_set_rw_addr - issue SET_RW_REG_ADDR request and wait for it =
to
>   *                        complete
> @@ -370,9 +384,7 @@ int memstick_set_rw_addr(struct memstick_dev *card)
>  {
>         card->next_request =3D h_memstick_set_rw_addr;
>         memstick_new_req(card->host);
> -       if (!wait_for_completion_timeout(&card->mrq_complete,
> -                       msecs_to_jiffies(500)))
> -               card->current_mrq.error =3D -ETIMEDOUT;
> +       memstick_wait_req(card);
>
>         return card->current_mrq.error;
>  }
> @@ -405,9 +417,7 @@ static struct memstick_dev *memstick_alloc_card(struc=
t memstick_host *host)
>
>                 card->next_request =3D h_memstick_read_dev_id;
>                 memstick_new_req(host);
> -               if (!wait_for_completion_timeout(&card->mrq_complete,
> -                               msecs_to_jiffies(500)))
> -                       card->current_mrq.error =3D -ETIMEDOUT;
> +               memstick_wait_req(card);
>
>                 if (card->current_mrq.error)
>                         goto err_out;
> diff --git a/drivers/memstick/host/rtsx_usb_ms.c b/drivers/memstick/host/=
rtsx_usb_ms.c
> index beadc389f15f..403144a39a53 100644
> --- a/drivers/memstick/host/rtsx_usb_ms.c
> +++ b/drivers/memstick/host/rtsx_usb_ms.c
> @@ -551,6 +551,13 @@ static void rtsx_usb_ms_request(struct memstick_host=
 *msh)
>                 schedule_work(&host->handle_req);
>  }
>
> +static void rtsx_usb_ms_cancel(struct memstick_host *msh)
> +{
> +       struct rtsx_usb_ms *host =3D memstick_priv(msh);
> +
> +       cancel_work_sync(&host->handle_req);
> +}
> +
>  static int rtsx_usb_ms_set_param(struct memstick_host *msh,
>                 enum memstick_param param, int value)
>  {
> @@ -787,6 +794,7 @@ static int rtsx_usb_ms_drv_probe(struct platform_devi=
ce *pdev)
>         INIT_DELAYED_WORK(&host->poll_card, rtsx_usb_ms_poll_card);
>
>         msh->request =3D rtsx_usb_ms_request;
> +       msh->cancel =3D rtsx_usb_ms_cancel;
>         msh->set_param =3D rtsx_usb_ms_set_param;
>         msh->caps =3D MEMSTICK_CAP_PAR4;
>
> diff --git a/include/linux/memstick.h b/include/linux/memstick.h
> index 107bdcbedf79..e86f7f6e3e4b 100644
> --- a/include/linux/memstick.h
> +++ b/include/linux/memstick.h
> @@ -285,6 +285,8 @@ struct memstick_host {
>
>         /* Notify the host that some requests are pending. */
>         void                (*request)(struct memstick_host *host);
> +       /* Stop using the current request; may sleep until the host is id=
le. */
> +       void                (*cancel)(struct memstick_host *host);
>         /* Set host IO parameters (power, clock, etc).     */
>         int                 (*set_param)(struct memstick_host *host,
>                                          enum memstick_param param,
> --
> 2.43.0
>

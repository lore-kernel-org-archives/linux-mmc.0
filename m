Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C46C4189C0
	for <linux-mmc@vger.kernel.org>; Fri, 10 Jul 2026 13:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783689726; cv=pass; b=IH3NhYcEfJPfcs9u9u9LFJXkSc/hQwCdbdfotVIt7YQSiiWH3qo0JxpTJISfDSgIviJQnc6iNddBYIjdFAyj02hhhhPFt+kEU/kk17VMWSdI2CoK1tTcAf1OafmtWsfATdEjqj6mGxCgVUaKXK2PTUVRgoWi0TurQfM522ltP38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783689726; c=relaxed/simple;
	bh=1uNMbm7LIN3gxrFZXWZX1gSuoAakDxS+XnijlDSe7kc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BvLEiBAzVYOnF8H59S94MFkIBbDE1QaILvPwNfLxbNBxlGzEEkXY2Id4nv42fgQaWfEMT5xTGCFPSw4sHETHHSNA0poLA6yn18at4FMSSUrjlEOM2hzr68Wmf44Qng84vvbJwpl/t7H2nB4DiLqEE3caMD5yiwOO4OOPpxU7X34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UK5CMeug; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=N6KC8Zv+; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UK5CMeug";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="N6KC8Zv+"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66AD64jS970072
	for <linux-mmc@vger.kernel.org>; Fri, 10 Jul 2026 13:22:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	P2YrylrRrFwth3jTM5pBTi0+UfhwHShrt0Qu91K/4RI=; b=UK5CMeug+vXG/LK9
	/CajDQ19pLFxtTnvpuOV1ZYCGShbDFoFj6Cq6XlhHdtuBcB+9wWX4J20SDgJnmuM
	29MIdzgjof3XneiQlY6UzS0C22+CnlRWb0fb18M1YOl3cqt5OlgZyS/6pJdYKLIo
	/lEvyWsHXo84OyKN4k2LCk6dL7Ys3gk6iQoEy/w1q4mJQKS66dyVmk4IBpEaefj+
	8/9b0dPU3jLfzuKudDTZgRFQFdbAwp0BBrfIbobaSpAYemT865mirW6IOhliNrVJ
	bk8ZIdxjRGJK9oZnGFYCXMBW/KKzBLWfM1k0yH0bGghpmMfqvgN2hdAgC9DLWDhH
	a9g52g==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faeg3mmbj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 10 Jul 2026 13:22:04 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8f45dde7595so12154566d6.3
        for <linux-mmc@vger.kernel.org>; Fri, 10 Jul 2026 06:22:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783689723; cv=none;
        d=google.com; s=arc-20260327;
        b=HRq7joHkQ3wF5tRGi9u2B/BsGU5x9K7P7JXy6TffYcttVS3fzPJ56MiYeibHOw+EHl
         Nz4pXZf/9oG4NDzeAUuFfFIzpjSmSsneV3tOsBUsCmQ02GIf0Z6bWyTIqj2tPy4IGf7K
         4W7Fbvl9RQJgo034J20+mdT/81jGNDPcVAvazN6hKsLOcoxBkUWrrTt/WTvc71MdS35F
         7wWiTGNAJkvK7zFO6rCCklW05v/ocZfS20RyuYxss1yXbDCzDefIMIgkQ5do8xCt7Jd+
         CZAG8Sxl8HLudVJA88dx2GA01BoSYt7kQYvAbI9S+JORL/9ZvsEHNxUI6gVNMGth9iM9
         xT4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=P2YrylrRrFwth3jTM5pBTi0+UfhwHShrt0Qu91K/4RI=;
        fh=kjhfPm0BAiK7hlAmVsQ7qnB8DcO76tkKe8kod6hLx7c=;
        b=d5jF/arrrZGeSO+I4HyGV3aTG5aBo0ZK+pPrzt1L2Kgo9ctFwOTb4v+JsSePcBWwrC
         1+E+GYRxwHY9ZqyQQbDsYm5T4VGtMMOp9uZ16NGkdKxDD7nrwpwiXl5ndyfpu9AikNOP
         pZHpOMifoupHLBVZwvnwNHH3TxmB8JDYTBEUHzrK/7baoS66Igp2cKB7WMkmfdcNtIkW
         Re6nOoHDd3pGnVzGa5ih/REnCFD9Z/Okg83XafyXi150EGIduqj/TuciaP/BELjfGKXN
         OJs06JecmZr0n9WmJUk7NHnUv0LuwuVlQqW7OtFq+Oplq2zENUN+Ijzqe1NLpQ+F5nm9
         vf1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783689723; x=1784294523; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=P2YrylrRrFwth3jTM5pBTi0+UfhwHShrt0Qu91K/4RI=;
        b=N6KC8Zv+eHk2l6WV6mS9xKFIgSsS/cJmFNcGIKwRtkU/BxwU3lBK3fzB5cixcJI/9Y
         cv9BEpe0T5qbMDTLT1BsC22t6Xe3+3c1N8bZoZ+ibRu4sPNd1P0lFKlAMGK9x3Sc4cI8
         h+cduEi6TmysBbPxYJTHTDMdZR9JLgXo4+5S53Vj5+75oLM18MqUf7Pq9WMPHVDKRKxH
         pBT5vOA4zzfmGtMH+UeIVOhhl37rxUI98sHhPSPcu8mUuer53U/0xZqrBTtmGO6FyCkZ
         JYxOKpePzaygbTQO3RnA12maQ7aXTplzzTj7tv6W09PHfyRCMnMZ/pXcx2F51KYi3T4x
         c07w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783689723; x=1784294523;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P2YrylrRrFwth3jTM5pBTi0+UfhwHShrt0Qu91K/4RI=;
        b=nnFNf570Zsiv4aimMY3W6tQSeP/Qqcx2CdE0MeXFrd54Bb8msIykug3EgYgzQgyTiU
         kPVTq1gtCuNFiOivOnAjWKs7jv8/tTCYRRtEYqsbtnoLFFxOon5RR7jsrDpjagy9KNYw
         FjF2EP9aQaa/aQN//TtZHEPbT0D4Uw3Q8b/E0zEL8kyjP2eGFwlz2K/sGMHXJgr2Ymfb
         Ibbpuo4krvm0saB8X93OJWey/7/Am7aqmXaJee1u3EItZxxhEMUDVnrTWTqCEJAbOTBo
         HwXd6icNOkffBUtcljowM28MAHeatEpoOaULBHrKb98y/1DrFe6oPFYZvHzpVFXgQ8rJ
         bjaQ==
X-Forwarded-Encrypted: i=1; AHgh+RoU/EpryyR9oL5YBG2qDS2NbZ4O4+aeQOmMvB2eD7mpkg86vARR6f/gxn1zhmJ1bUINW8N8n9AsfMo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnLSIP+yE75JmWIF5gOWN/XHq5iqDFuOCM/8TzKrQH1fuL50YM
	NcpHXYujtrZgUqeZpFm6mX3Q43Th02McKy8VZm+19H6wLxE43V8tCSQWBRww78183zqLpTtqS5S
	z9kFdPdGYZx8xY+CNM3tkuEM4ZCJf4LR5apj/Mhr7KC6M/GKwCdfVsHMXvdi/X08XNxp75/Rl/9
	kcUJ9/Zjmky+rqCoIRm6ptJyPnoN6FrqhG8vXKOw==
X-Gm-Gg: AfdE7clHnXq+LVZJ9gCZpytC8chTzv4OK9bdJwJlBv6JJ8kMrWaADIF22qPd9eFXRrE
	h5cbPdB+juXUyEPEJZtM2R1cQFdRoVuSpykV4nVyU5TrAMAI2fmuhPUgO/560cw3qtZ3op1YeAl
	5snmCUmOaJtYSMTo53/3hQ+EsmpoSdLVuZ3feBKI2ZcdXBnHRfM8ipdCNWtL6ybRQf2IUq
X-Received: by 2002:ad4:5f86:0:b0:8ee:9f8e:e910 with SMTP id 6a1803df08f44-8fec1994bffmr121315316d6.28.1783689723176;
        Fri, 10 Jul 2026 06:22:03 -0700 (PDT)
X-Received: by 2002:ad4:5f86:0:b0:8ee:9f8e:e910 with SMTP id
 6a1803df08f44-8fec1994bffmr121314886d6.28.1783689722629; Fri, 10 Jul 2026
 06:22:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1783352430.git.sean@starlabs.systems>
In-Reply-To: <cover.1783352430.git.sean@starlabs.systems>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 15:21:51 +0200
X-Gm-Features: AUfX_mzjKZvh3jAqrTi97TpQXFI13W37Ib4M0YnJQCIteQT0Mnwypyq9xNU7n4I
Message-ID: <CAPx+jO-ShdxM_s7Tg3KpRtaT7EAxGnT1s4hqBEqRFZDECVWEwA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] rtsx_usb: fix tray-reader false card detect and autosuspend
To: Sean Rhodes <sean@starlabs.systems>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ulf Hansson <ulfh@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Ricky Wu <ricky_wu@realtek.com>, Lee Jones <lee@kernel.org>,
        Roger Tseng <rogerable@realtek.com>, Dan Carpenter <error27@gmail.com>,
        Jisheng Zhang <jszhang@kernel.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDEzMiBTYWx0ZWRfXxeciCjO7ESEn
 FlzxiYmUrhtNXfpZpG2LQB85YEmgFjHy0WgTDaG8c039L15tWb1D7OeRv4vMBiimdG1DhORHc2R
 gURiszwrDKR78zvSvVg8EvgqHfyCORfOBo9L94jYSZVjivCKYvEqNKSytPCTU/iLC6PrUNTjz2o
 OE9ZeLpZneZi4c+CHNlN3DczLvJD0eDpcjVnEziQ3wCwgQt/LQ89oJCd5V+QVY+hOnFzLDt+hgB
 +qbgVWK0RiWuLvVEKK5HHVWZCUKHoNkc2+tv5HUUlNFL/alGRqDDhN07L1XQXJZVYti+OlHT4F7
 KDBOyY3PYOJRrKHrJdiTXOW+8MBffXp7sJM2sllCI5G7vcSCfXUzDOOtkkFVw0ZVtJPDTd956Z+
 5qo+PjLohBGAmw1Fw3Vnz84BtNLOenWw/J9HxbdPV9V+VYxVwLyQU4xHR1Dr7gu/IsBLKKW4H1q
 SBidfTWMUcpc9z6wo8Q==
X-Authority-Analysis: v=2.4 cv=ZcMt8MVA c=1 sm=1 tr=0 ts=6a50f1fc cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=r4HqzUrTTupLGTJP-PQA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDEzMiBTYWx0ZWRfXy4batWT/R0jA
 RxJ0bUmvQ2Gktk3Qy0xNTl8OTjsh19Q1QKOwZI5IGRd4W2NIqoFcF0+1oHvgP7qkA1K9Yukaaez
 Y8uGT35pmmACn0kjkrGJG11aKwCHTdg=
X-Proofpoint-GUID: oK0YvVse8WclSj2S5UvWXfGFCx9cJ7V8
X-Proofpoint-ORIG-GUID: oK0YvVse8WclSj2S5UvWXfGFCx9cJ7V8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100132

On Mon, Jul 6, 2026 at 5:40=E2=80=AFPM Sean Rhodes <sean@starlabs.systems> =
wrote:
>
> This series fixes the empty-tray detect loop seen on a Realtek RTS5129
> USB SD reader, while also avoiding USB register accesses from the USB
> runtime autosuspend callback.
>
> Compared with the previous RFC, this no longer qualifies media by issuing
> SD/MMC commands from ->get_cd().  The rtsx_usb_sdmmc child still reports
> the raw card-detect state initially, then lets the normal MMC rescan path
> probe the media.  If an initialization command times out before a card is
> attached, the SD child suppresses the raw SD_CD signal until the tray/car=
d
> detect line drops again.
>
> The parent rtsx_usb change removes USB I/O from runtime autosuspend and
> keeps only the existing Memory Stick autosuspend deferral based on cached
> card-status bits.  Raw SD_CD is not used as a parent autosuspend blocker,
> because this reader can assert it for an empty tray.
>
> Runtime-tested on a StarLite Mk V with Realtek RTS5129 (0bda:0129), using
> these changes as a matched rtsx_usb/rtsx_usb_sdmmc/rtsx_usb_ms module set
> on Linux 7.0.0-27-generic.
>
> Device enumeration:
>   Bus 001 Device 003: ID 0bda:0129 Realtek Semiconductor Corp. RTS5129 Ca=
rd Reader Controller
>   /:  Bus 001.Port 001: Dev 001, Class=3Droot_hub, Driver=3Dxhci_hcd/12p,=
 480M
>       |__ Port 004: Dev 003, If 0, Class=3DVendor Specific Class, Driver=
=3Drtsx_usb, 480M
>
> Card inserted:
>   mmc0: new UHS-I speed SDR50 SDXC card at address 544c
>   mmcblk0: mmc0:544c LX2TB 1.82 TiB
>    mmcblk0: p1
>
> Deep S3 with the card inserted:
>   PM: suspend entry (deep)
>   ACPI: PM: Waking up from system sleep state S3
>   PM: suspend exit
>
> After resume, the card remained visible:
>   NAME         SIZE TYPE FSTYPE MOUNTPOINTS
>   mmcblk0      1.8T disk
>   `-mmcblk0p1  1.8T part exfat
>
> Empty tray:
>   mmc0: card 544c removed
>   /sys/bus/usb/devices/1-4/power/control=3Dauto
>   /sys/bus/usb/devices/1-4/power/runtime_status=3Dsuspended
>   /sys/bus/usb/devices/1-4/power/runtime_usage=3D0
>
> With the empty tray left inserted for about three minutes, no repeated
> MMC detect attempts, command timeouts, or USB reset churn were observed.
>
> Sean Rhodes (2):
>   misc: rtsx_usb: avoid USB I/O in runtime autosuspend
>   mmc: rtsx_usb_sdmmc: suppress false CD after init timeout
>
>  drivers/misc/cardreader/rtsx_usb.c | 26 ++++++++++++++++++++------
>  drivers/mmc/host/rtsx_usb_sdmmc.c  | 13 ++++++++++++-
>  include/linux/rtsx_usb.h           |  3 +++
>  3 files changed, 35 insertions(+), 7 deletions(-)
>

I decided to queue the series for next to get it thoroughly tested.
Potentially we should also tag these for stable kernels, but let's get
it tested a bit more in next first.

Greg, please let me know if you have any objections that I pick this
via my mmc tree, or please provide your ack.

Kind regards
Uffe

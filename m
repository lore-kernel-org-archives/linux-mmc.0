Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDFC3F1AC6
	for <linux-mmc@vger.kernel.org>; Fri, 29 May 2026 14:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780065959; cv=pass; b=XihRmWgX9cG04rIluelNhbqzoppFkQGXyzfyHCu20aL0TTpAnMyFQY509liP+Fe76qT0cTKoW1tSR1VfZNYMxS9LbYzhspKhQOrt7h+bY5gGyOuAvQz4FEl4xO0QLmvtJQ7WiAc4THE3QtYSVQ9O0u+27qetsJJFmbGwFc3Dwoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780065959; c=relaxed/simple;
	bh=+Ix458awdQI7DKAuxr/xCBCftZo5qHwMMJQHpztJpzg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=trwKicwVoXDPsbySkODaM5QzHYHYpCIw+ptYrv4LIkhQwxFg9O2zA90744QZIX1wcvdccTp+o1BRFOJgxVF1h9H8Mq/xMI63QqXry2Oc/xdAWUqvMCYiTNpMeq6A+6CEZ3DI9ADKyc10/kJuEiBrRcrz14JQhfvfMmhOUtRQjT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bRxpvlSP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bIxo3Kaw; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bRxpvlSP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bIxo3Kaw"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TDKxkE3729436
	for <linux-mmc@vger.kernel.org>; Fri, 29 May 2026 14:45:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yDnD3Kr1cUWRx3HXGeCkT/A9WB2DsDHsDWqODL0GPwM=; b=bRxpvlSP497MgPRS
	6fuIwPz8etOTrBElqYCsZuwoM656liTTeB4Zl6/e7QQvxXVj84VCrDGA3PVdJxs7
	6cqj2yHaEzXoNsIoTm7jgrjln+6ahkpF/g4Ij7soYOX77WTEtDATR8J6tR9ofqya
	ybc1a21HQ1Fb1R6WGjEBRmswxnUhAZXB7y7S3+2pH2jz+1ubbgunGDH1IszBelMk
	HVW+chK48utagSC4ef/4ZlnENUMlxWTj4UH46iK4EcQP/mB6792DsgQjvXgwXa0H
	Q2+0uE4lw5CHb7Nz3igFmcU9oOAdNqGciKi0eKQC1XtsdXQPBeE/e9d15Hfk932v
	X0KvzQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eety4vn4w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 29 May 2026 14:45:56 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8ccd51bc2f5so39695606d6.2
        for <linux-mmc@vger.kernel.org>; Fri, 29 May 2026 07:45:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780065956; cv=none;
        d=google.com; s=arc-20240605;
        b=k8En7yVqMmb6k3AUyUer5CJQTGnBk7KdChHiRgplc7cHzgbGE8w8oEvui7Kt2NFbig
         x/jFjtvXlLcydM+eMQqI6280/0Lli9ByruztmhrHg6tUbb6/3IQ1rGLUPKWzDJYgWzB5
         lLQIkP4DK9ctcwEe9dfG/s2lGUHB0FWOAWKSAwb8sdhxdzPK9wRndOFFuCctYYcO6/Q6
         q8l/Il2sqEUJlrzj0Aybaca8AO3luiaKbHQ8Ut7lQNM+jMx7eHKqfZeO4worYYejD13p
         pjpDHgUTUlE1nXS8OsM5xosYzEnPIhwiDPg/44CCYsBWT8vLbt+qWEqsPW+ZUzEIFD03
         f4tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yDnD3Kr1cUWRx3HXGeCkT/A9WB2DsDHsDWqODL0GPwM=;
        fh=l8jbSMwNa08m/5jyK6zYUMdpniM9gILBZHNpbLDX2R4=;
        b=HHisajhypkgRLCgaxygAzh0c9N9XT90mcRH/JmdbIvKtZmS1852mYZfqMcdV45xKmT
         C+UIGAxPXvwUGfikrB3EPszva3PzbjTQTXwhbjuUqOMuCpVsjVdB83U065oUcAdtruMC
         /sPK28G0O0o1v7ad1SssNeSu/3xpf/W2vf39UYIK2wl8EbDNLX7Ww6YBv55d12XnFa/J
         xkQbdyN9AIjpGV58GqV3QA8FIMQtOTDzBeX+OdHKMm5WjKWHOTPwTYVtROsO5VUUZXpw
         ePlDRK6fVReDAuto9RbSJPH9QE9FUjYjqAQZwFeVBwY5dTYlij/fwdpBu0StyAI+qVqf
         4XKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780065956; x=1780670756; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yDnD3Kr1cUWRx3HXGeCkT/A9WB2DsDHsDWqODL0GPwM=;
        b=bIxo3Kawx6gG3h20jYDim0SfO8TW2R1aXOFs0Y33uxYCC3wUfEZ37JMlaTvyXJj5tC
         OJdwqdFn9A8T7rBRyQaM5k9J5VkdRJNRq3d2PnMMOlo5FFvkbWNuccY6Nynde50wH70b
         5c4JPcLET+F55nqoU09LldSe5eB4feS6rYpFD0IrvUfxtkhGJSjMq0GKf9hk4Kaa2c8I
         eEy2sQ1Uy5+J1E/ZJKnaphyPYPCuVb6RE3p2VW3iLu51Lu5T+LGAgbH2zcmY/qs+YrHT
         mt/j4lREwybRZbJ2Dkk9YsyTJ35Yo5IxJt1YsrAOUydAyVsRTpMN6FcqJF7TrVY/OH6X
         kElw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780065956; x=1780670756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yDnD3Kr1cUWRx3HXGeCkT/A9WB2DsDHsDWqODL0GPwM=;
        b=PmxqxALWU0rQnh6aWWXNl/mKnBj6XlLJByl1ZCt6HBcMqJZ/JTNF+fyFMY9lIaOg0i
         TZuCwEaaBFbovrEzkAPzgw2I+1d0Jtqd9CVt7CBXf+Zqn7Hhi+8ym6LxCBnJ6tIwoCqa
         rNMUPTchtOMXIuoFyae7hFCaEj6RrbfJ8q4OpZNXLhSMesCVtuF45WBj0P8XPU1a4ReZ
         ERRx/cGeDHxn1o7xMFW8rq8kNoBwFqo+97HRoy93VzzohtqlXkJd83fyBdbRWNs3pmmj
         QbAshG9dsbeOg/q6OSm7P+XH0lSl62owMITZusS/RdPJYqGBYrZf2mSuPUBSBpDKtYMO
         DCZA==
X-Forwarded-Encrypted: i=1; AFNElJ/UwkHD6sfKD5d8xfsog4PcZzhvufwAiUxDjF1Yo0Iu7QmbaoEXxDXE9YwERp5GodO9xMLumDs4n+k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn1gRabWMjigSXOxKLwxn9LeR1QtWBN2Q5MZ3Qt+078xZWplWC
	cZ9XCJCirL8CblaYAB1qDHgK06x3VFKC6ID5LEDb1MOhVMTWn9kpBJtIUoixNkLPHJIXZIuwtFB
	LzS1izJ1aDSzy56nX3j/8GdRuOAFDcJ0siCs3bDoeKfsU1zdBhENSpWnDbkyDFJ9E5L+mEWjg9D
	zZZSbPXE6wvMHbJdNIkZPDhMx3IWTeWFBfTxhCBQ==
X-Gm-Gg: Acq92OFJbKQLGv6/xoSBX2Bwxbf85tyMULaX0oxcFozMZ/Bcr8LYc3rNzjPqBcOaYy2
	nflI2SyRNyWoJShE6pOXcmEQ++Ds7SOJMxSiPRdbXEaKE2dIkv+RhwxjV+oOXaWoWBh1FnwwBzE
	JGbaXPwe5EfH5YDlXCPE9nEqI1nCVAlia1rcEBvNTllPrKrkA6EeZTLmZQuS6wIgeSd/+IicOof
	BzTBJ2Ntok8tXX21w==
X-Received: by 2002:a05:6214:48f:b0:8c4:edb4:a44a with SMTP id 6a1803df08f44-8cce8274ac4mr39696366d6.23.1780065955983;
        Fri, 29 May 2026 07:45:55 -0700 (PDT)
X-Received: by 2002:a05:6214:48f:b0:8c4:edb4:a44a with SMTP id
 6a1803df08f44-8cce8274ac4mr39693536d6.23.1780065950513; Fri, 29 May 2026
 07:45:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521072122.1601215-1-inochiama@gmail.com>
In-Reply-To: <20260521072122.1601215-1-inochiama@gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 29 May 2026 16:45:38 +0200
X-Gm-Features: AVHnY4IPJEd5tSd-tHn1NH64tHCGt5-xFwvrj3NaUawHJxylmFEcuKt17rjo0D8
Message-ID: <CAPx+jO_zY9jcV_6SD7HtvrkMo2534NE5o2nbxYmePP=XFXWV5A@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] mmc: litex_mmc: Set mandatory idle clocks before CMD0
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Gabriel Somlo <gsomlo@gmail.com>, Joel Stanley <joel@jms.id.au>,
        Maciej Dudek <mdudek@internships.antmicro.com>,
        Paul Mackerras <paulus@ozlabs.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yixun Lan <dlan@gentoo.org>,
        Longbin Li <looong.bin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: 6ubk8k-UC5i2VtVYzxMVwhN1E4PQG6SF
X-Proofpoint-GUID: 6ubk8k-UC5i2VtVYzxMVwhN1E4PQG6SF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE0NyBTYWx0ZWRfX+u1PKNtW8Abx
 NK1pkQLgGggKbIFpWiSAtGVm9H3CgyjCh571nHs5rZlDI79W4pZ2tGTX3pmREOLx2CE+GmWB4Zt
 7Mi0LCQA/a0XNQ7NyavzlNcbdQJ9v+L1eTC6dqQVs0CcFN7/vdMyLEMdT50XrI32s3XnH8DjLca
 Wzcxs9jZ83NR0P2FUszfnMUd4Io5AUkxFxAtWSUicX1YZgog09DteZOAiSMSd67tD3gXZCnTXTK
 IIzV0ZJ1vmWGam6V7gP+Z/UTVX7LLLTwKI7XaFjNGjxjZ8/M/fAdItdZDwFwI2r4wvC1+H7MAv7
 4F2H+HGYtBnabM3O0+XyGb3Lq85dDW9+Fu4y6nj6bMw/iZFH+KrinJTR7CegviL9npvVWHSWWPH
 zjjrfHRv5GUfEBnlpYy4s4ESEcRmrB1keFxpRdl8mA/iY7EX+v96CKfzOT2cXGG6tuUqThOAbei
 yKQIJEyyWS/DM0VchZQ==
X-Authority-Analysis: v=2.4 cv=S+TpBosP c=1 sm=1 tr=0 ts=6a19a6a4 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=towx7yCl5YjJ_Rnf6CgA:9 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 spamscore=0
 adultscore=0 clxscore=1015 impostorscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290147

On Thu, May 21, 2026 at 9:21=E2=80=AFAM Inochi Amaoto <inochiama@gmail.com>=
 wrote:
>
> The litex_mmc driver assumes the card is already probed in the BIOS
> and skip the phy initialization. This will cause the command fail
> like the following when the old card is unplugged and then insert
> a new card:
>
> [   62.923593] litex-mmc f0004000.mmc: Command (cmd 8) error, status -110
> [   62.949717] litex-mmc f0004000.mmc: Command (cmd 55) error, status -11=
0
> [   62.976606] litex-mmc f0004000.mmc: Command (cmd 55) error, status -11=
0
> [   63.002516] litex-mmc f0004000.mmc: Command (cmd 55) error, status -11=
0
> [   63.028442] litex-mmc f0004000.mmc: Command (cmd 55) error, status -11=
0
>
> Firstly, fix the clock divider calculation so we can get the right
> clock frequency, then add required clock settings and initialization
> for the CMD 0, so it can probe the new card.
>
> Test Results:
> Rocket:
> # dmesg | grep mmc
> [    0.109176] litex-mmc 12003000.mmc: LiteX MMC controller initialized.
> [    0.256926] mmc0: new SDHC card at address aaaa
> [    0.257058] mmcblk0: mmc0:aaaa WC32G 29.7 GiB
>
> Note: it seems like the rocket give a wrong DMA result when the target
> address is in main memory.
> See issue: https://github.com/enjoy-digital/litex/issues/2464
>
> VexiiRiscv:
> # dmesg | grep mmc
> [    2.368365] litex-mmc f0004000.mmc: LiteX MMC controller initialized.
> [    2.576993] mmc0: new SDHC card at address aaaa
> [    2.588966] mmcblk0: mmc0:aaaa WC32G 29.7 GiB
> [    2.620197]  mmcblk0: p1
>
> Changed from v4:
> - https://lore.kernel.org/linux-mmc/20260517015323.264179-1-inochiama@gma=
il.com/
> 1. Add a new patch for fixing clock divider calculation
> 2. Move everything in the set_ios() callback.
>
> Changed from v3:
> - https://lore.kernel.org/linux-mmc/20260426112016.1370929-1-inochiama@gm=
ail.com/
> 1. Remove patch 1: mmc: litex_mmc: Move litex_mmc_setclk() to bottom for =
reuse
> 2. Use set_ios() callback to apply the clock change.
>
> Changed from v2:
> - https://lore.kernel.org/linux-mmc/20260424013615.470325-1-inochiama@gma=
il.com/
> 1. Remove the added function forward reference and add a new patch
>    for moving litex_mmc_setclk() function
>
> Change from v1:
> - https://lore.kernel.org/linux-mmc/20260421025052.755471-1-inochiama@gma=
il.com/
> 1. use fsleep to replace udelay
>
> Inochi Amaoto (2):
>   mmc: litex_mmc: Use DIV_ROUND_UP for more accurate clock calculation
>   mmc: litex_mmc: Set mandatory idle clocks before CMD0
>
>  drivers/mmc/host/litex_mmc.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
>
> --
> 2.54.0

The series applied for fixes and by adding stable tags to both patches, tha=
nks!

Kind regards
Uffe

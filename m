Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE654AB1A0
	for <linux-mmc@vger.kernel.org>; Thu, 10 Sep 2026 16:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789056363; cv=pass; b=JtHxuK+5m8tLS/4G+UpAEBvwpwCRm04Yh/W9aGvSaUZJonIM42Rui0DsMCu3UOIiFJOz0rUkMCZfPwE9zGRqVOwkpEmcS7KZ53o3FhzU/s9+7XI4BfvsyybzsSwgVF1oAO7JZkOflWbIWfu7GV+eX2gjg8tKd5ASrfm2Rl2f4pg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789056363; c=relaxed/simple;
	bh=QEVsCcOWfGaLNWBpaPeA9zZXn/J/tBa9cqnHzXlkuyo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F0OkPRZbqM+iX+6NKIvjsx6ntiFIVOeFNdIgjJK+zXOsrih1SuK05TAv7qfPxVu1JVLi3m81MX35QPmU23OUFz6deg5h5G3DXhiyjA/LEhIbyNuKYORV6xtaZjYL7++YH2vGlm7NYVfZ6483nS7vZUyKrfm+QDw+bmDQliSzO6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dGYKOzHR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Fzq25TqN; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dGYKOzHR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Fzq25TqN"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68AF55IY650750
	for <linux-mmc@vger.kernel.org>; Thu, 10 Sep 2026 16:06:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	brsDMVitZFE7oxK8lWXE8MNKRDnR31VfHMnWrvmZodg=; b=dGYKOzHRMuN54eE5
	t0pdAi1QS0cl4kWYufaWigNOxD41SeGv2zDMz+lm8m6TcM9t9GobEoLb9QEHakjw
	LWFTa8Fb6AEUNiXPLTC2Acb7SIFiNXmd5z9WdCmccJXjccCIBxyg2KvdzWATQNZx
	iS0ohnkDwe0rqvA90coeXeBzt7IipphWzEK4+UDiuIvyb+JjB+t90PO/XX0G3a5p
	+wH1KeH8vTk9bldcNM+EDXXyIsp4k91oHIPpH+y6v3oJic/Bcg97AKnI/H53eKaK
	ZJ3wdcwvjNa09J8nlPPpRs2aZ80QFAvsrwMW6f4nyg3mu2oPjp7753NJdtRXVjdw
	x/lKoQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkxv78b7v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 10 Sep 2026 16:06:00 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2d94a158dc8so120220705ad.2
        for <linux-mmc@vger.kernel.org>; Thu, 10 Sep 2026 09:06:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789056359; cv=none;
        d=google.com; s=arc-20260327;
        b=Ah7RFWcMy4NizMg9UK/OTvdEc3RkuDZgmFFjQDc2kzVZ4u7l3hv643vBUydcxx0sNl
         Tg070jG15IJKSQD6R7dDUuNSMEwkbxOj4Z6NJKsXvVIrMHhomZQMFWE6cTiJSVdweEB+
         AnHKuaK0hKq0sqs/uqhrN+qxO5cvYF+Tvh1dqtlx75fBhHPMBkAksU66C+eTMVCwk5u1
         s+knGVSYWpGknbnZNx/A9aspOCJZLyfNA1f/XHi6uRsscF6YszrQLkc8HyttfCpu+6j+
         /iaSk6N19KQwPPufjhhRUJ8b8wJ4yT87uUgZ6rcVBMQaP/0R7jz3JDoO2CDkkLShdSee
         jMag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=brsDMVitZFE7oxK8lWXE8MNKRDnR31VfHMnWrvmZodg=;
        fh=nyEufAtAboUo7pcbMxsRPIRJIwnIQruTdGI7QxiC36Q=;
        b=IwVy8vM6TcdfK7Wf5xK/SEN3fmC7nGh7NQ+lloXdVyyDUt2FigKOgoqSeAYd4mcp7E
         wxbjJbxMhkIOzEaqlAuq8dTL6a80czv/KZeB5TjzmruwV8zxytEbnfO/qSSHotoMA/7S
         wdcXvJBkonRlhl2uJqhf2bVs70t1GHDIBLACETAExGKeG1YSc2je4WMjCO/veE9EwMpA
         0k9aKZHeLF4G0/50gSHJvLyCTTIpddBufGfwxOC75zc5ldkOG4KbBc7TrAJNLUVKEu7A
         Xi+GhV6LQn7A4YdPOBcyeJmjBkfKXKaVf7HXzsBhxCbz+KczdknpoXz6jQaLOPhCThe1
         aYWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789056359; x=1789661159; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=brsDMVitZFE7oxK8lWXE8MNKRDnR31VfHMnWrvmZodg=;
        b=Fzq25TqNZseDwt94bJ/4g+eSXK2Ix0nnL92r+IfQpeNNI8mx4ELa8yVnxOYJaS23fO
         Bq31DII6XNH0KLsdpd6XfP+m/4/bqPnRIDpY9Cf5/shaXbZLyaomypNIqrRqTPxyn77A
         oG5rnVIrZzEJGxE9jJ0lPYqj1DI9b5Ui4qyTd2xB8kRkuLOAHnG2C7bIFVY42yuNzdLb
         I8uPLuhaxpNbU++IvROEEnIEIz5th3RsJiiQTE8oYKuwVT2vN3ZfcYWI8vipJt14qWhb
         7sIUxqAiWDFFEIeVQkdwrs2Sfmes6juNaw2li7kL097H8QZHTSSMmGOZnoxKP6AYxuFk
         Xl2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789056359; x=1789661159;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=brsDMVitZFE7oxK8lWXE8MNKRDnR31VfHMnWrvmZodg=;
        b=NqmR6oka2zYwSWv0v7LabHThS+xVobA3IDnDZ7pFXa84M0RuSCQ/+wEKoFRBT9KtS6
         nPEmSU4scJCAHgcwl7W1fPuFfhoyWsEMOpeNNARPCeHtUz+o/P5H4rj/k72egP3xoM65
         jqvYvAfRKt2Un0YHGtZhDcZCX7/Hmkv8ahMTx/LiiPTJ2IF2QaOG4GKXziPxm1862lm1
         TE2EqoK753+bCuUSu/oJ1A5tNJ5DBNtd1tLfXscJOVe5bFLs9HFM7JQHsOE82qtmcpIY
         5R3PRIAb0ik78s2phSbKZRfWhEMQDkHnSJb861Peil4zTLVmvW8vMgbtonLA/A9QS2mw
         c4ZQ==
X-Forwarded-Encrypted: i=1; AKwUvBzIrNHxH+b2tu0IYC0FcOMoRfmv8ni3KBYARZ/wsZeWclgUgEy/voD41dtbmYpsjulo++WH/HWfZ0c=@vger.kernel.org
X-Gm-Message-State: AFuF++m0sBjDQ5U/vSMjzjcNyJvY/L7VawiYNEHcz7m9x6aBK0nq2+ak
	FuvQN+EBlV362dA/UrwdXg/AB1nthVgA8KjfXg+3zMxvFFIsP2/2aP6yCxqoBiOcOhtryMd2F5q
	fQd5I2+IDi/veF4UGUx+Sh/NjzWzhWm01nl9b0rlUOmO0ZJ8eYsCj69ZwGy8CO8ma5ZBGKJt6Rz
	jQnrX8W1AFAqSkB3sqJJPiu9DK6c54mnDhIEp/tQ==
X-Gm-Gg: AYBFou0jnghjBEM5nKWL6vRn6VmTMqhoAmFfsJiOacgcA1JbaQCkl9exME6ojrIYGIm
	QST4jnt5hR/OQXYqN2cKw93j1jQwxnecMFi0pOBFSL3+XR6sFkIuIVf716GUJdHwp3yi+SE5lWr
	hNlkTr1TwSi699VaSZH5KaoVVycFUEooTmNf2PWTqpxKXcAY1iitB8AjD6pg==
X-Received: by 2002:a17:903:1508:b0:2dc:fdde:30c5 with SMTP id d9443c01a7336-2dd2a35779dmr1041785ad.17.1789056359416;
        Thu, 10 Sep 2026 09:05:59 -0700 (PDT)
X-Received: by 2002:a17:903:1508:b0:2dc:fdde:30c5 with SMTP id
 d9443c01a7336-2dd2a35779dmr1041055ad.17.1789056358895; Thu, 10 Sep 2026
 09:05:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1788826860-153971-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1788826860-153971-1-git-send-email-shawn.lin@rock-chips.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Thu, 10 Sep 2026 18:05:47 +0200
X-Gm-Features: AcwNN1WZ2BqvpdG3_WtHrn-rYoRhMwcMjL8lK1omME4kry53r9whz6H7gYeYX2c
Message-ID: <CAPx+jO-YgSkE-7YzPLY=6RRPoPDJrJJtBHoRC-bzGY+2ZjRE4A@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] mmc-utils: Add eMMC health command
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Ulf Hansson <ulfh@kernel.org>, linux-mmc@vger.kernel.org,
        Avri Altman <avri.altman@sandisk.com>, Shawn Lin <shawn.lin@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDE5NSBTYWx0ZWRfX58bUhEXCUqsZ
 WUrRFHPUVE8tjIhb/GXnL51NigprXxV9ZBt7gzIJddDtLjl+K2qWvBx1aOEGJjZZw/pxBP1Re9Y
 +f7oKnvrt6ANZjaIZbbYIsSxmvyr1NI=
X-Proofpoint-GUID: msn9whi3OiJJRSXRgUnqc8UDfeKypAX2
X-Authority-Analysis: v=2.4 cv=FPSOVOos c=1 sm=1 tr=0 ts=6aa2d568 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=s8YR1HE3AAAA:8 a=MQgBscGg5GL2LZEJ3IcA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDE5NSBTYWx0ZWRfX+mmtH+0fmGuj
 hMbSs3iKKKNe1DDKQ3sM4Oe8RcfSz8S3JpXjeuODVNMxW2ybNd57ShEVV9tFvQtGqHQORJVWIZc
 QQcuWU+ujOYl/TeJiuLVjQFiT9UBjPoQaS7SzX26C5zmRpf5k5VgJ3DMC0ZqQcbdCQVeml27Bgr
 vhFkq2OtjsmzvtdvtD4AP6xJZJOFZliWeVjhqAJgDj1rTIrE1t25uWakfG3g4rNxnpiOjmJztrS
 Rso8TGhTYJ2fzgZo46KtYoQVt1BHOZt3Kaw6AjuAKWaNGSuYeV3wYdk2tOjgmb1CC6IROeZCLY0
 PtqKnQBMUOL/eLD9E6Dh+VRYHDpBfNpNcU2H5TdbLBL2HKjlCxa5LTR7IIzL+vTDV38+9aE/ukE
 7i5XuGu2UPfWD3xz3v61yAx88FKn0k0Owoo8PT/DC+ScqmTENnkRunyovzlNShYMpb3eSAJXd4L
 ebYWe2zD3ICUIYYoJRg==
X-Proofpoint-ORIG-GUID: msn9whi3OiJJRSXRgUnqc8UDfeKypAX2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_05,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100195

On Tue, Sep 8, 2026 at 2:21=E2=80=AFAM Shawn Lin <shawn.lin@rock-chips.com>=
 wrote:
>
> From: Shawn Lin <shawn.lin@linux.dev>
>
> Hi Ulf, Avri,
>
> This series adds a "mmc health <device>" command that prints a health
> summary of an eMMC device: the background operations status (available
> since eMMC 4.41) and the Pre EOL info plus device life time estimates
> (available since eMMC 5.0), each with a human readable decode of the
> field. eMMC only, as SD cards do not report any standardized health
> data.
>
> Changes since v2, per Avri's review:
>
>  - Dropped the invented verdict and exit codes entirely - the printing
>    suffices; the command exits 0 on success and 1 on failure, like the
>    other commands.
>
>  - The fields are now gated individually: the BKOPS status is printed
>    for eMMC >=3D 4.41, the Pre EOL info and device life time estimates
>    for eMMC >=3D 5.0, instead of gating the whole report after the
>    fields have already been printed.
>
>  - Documented the command in the man page and in the readthedocs
>    HOWTO.
>
>
> Shawn Lin (2):
>   mmc-utils: Factor out extcsd revision to string helper
>   mmc-utils: Add health command for eMMC health reporting
>
>  docs/HOWTO.rst |  18 +++++
>  man/mmc.1      |   5 ++
>  mmc.c          |   6 ++
>  mmc.h          |   1 +
>  mmc_cmds.c     | 183 +++++++++++++++++++++++++++++++++++++++++--------
>  mmc_cmds.h     |   1 +
>  6 files changed, 185 insertions(+), 29 deletions(-)
>
> --
> 2.25.1
>

The v3 series applied for mmc-utils master, thanks!

Kind regards
Uffe

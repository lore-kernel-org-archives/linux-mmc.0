Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8112C4611CA
	for <linux-mmc@vger.kernel.org>; Fri,  4 Sep 2026 09:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788514922; cv=pass; b=EveAs59qXEh/68OsUaKJ7s7sv02xOQmQkviKkV/Hllq9a3KplkFgiVb6RKs5uYsgkfrOBhf+5tpYrXh03u5QBI2evpVAkVRBLFtIk5yBBGIjbC2ShlZn3YuSxW+z2/12aosvG+W8HMqTZNwAuBkCBWrH8hGKGo3xWGdRXgeB29U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788514922; c=relaxed/simple;
	bh=zu7emRKboLzHXzyXbEcjLUBn53PCvlKoXemd+/irgw8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RR3ePNackALNfkqsPyuh3qi35NnyFcGeplwK1mrj51o4g5O/5PxuqjNyyoeLsHg1YUpH84O1TALGo37k9TEgDEkX1kYw+rRB/4EnmgIT0LIQlbscJ0Wd03EbWz6FtWHmjrl1vS7L/Bx1LThkizRFZMwNtn9OYBiSfXhYCfKS+mE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NNWooOyY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RyDT/8MK; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NNWooOyY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RyDT/8MK"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6847mptO2292489
	for <linux-mmc@vger.kernel.org>; Fri, 4 Sep 2026 09:42:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MymcqnZkHOqjUJcCaTmpmg9eKweEy9UxXP0OOYlsdYI=; b=NNWooOyY48IabF6h
	3KcJixiMdydZRJXN8MGlW/Vns1nXSqMnNboKvm3FVCX1gk/MYu8ftA7HhKPj3HkK
	KX1Dm0P/Jbh+pQ5tmhVDELDu8xZx3UTYHNgerZCd96PbmiiepMW9jaLNrGkBiKvZ
	wO7sgch6Hm0Ea5oHpkCX1u/2fz+Y4rxp0M05Pe4Q0Nq6BWdK5y6Lg1RahFvtchbB
	2FNqTkOxiuCZanqSop7wfwN+c2vS6woWA54JtXJOEbo6UzVedCRkxOEZD8uJi+Ek
	H+c6JmDzsrJW4GiZcHy7Mu1Qz2+Tty9VwmGJsYXlQwUwn4z7tczYYX00DIuatwJQ
	kjRycQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gfdyp2y8s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 04 Sep 2026 09:41:59 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-848568a6f62so986469b3a.0
        for <linux-mmc@vger.kernel.org>; Fri, 04 Sep 2026 02:41:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788514919; cv=none;
        d=google.com; s=arc-20260327;
        b=J5gAiepaW9flQUhXnMRhIL8HFIMSSUwxB+9o5VuFdgYMu1ZvZ4CXcljwJn3xNShPwt
         Wu7ZRKiyI/le0q5+RRGiaIH3C9mNCQXdMYI29X6ycKIvNHe4DBVAXgz8eLolj2YefY/y
         ZglCH+fGbFx31/qRQCbu3bmVp71N1w7hUg0DGk0n1lniIhxvgEfhZ7C42q/Dp5Q8KJVu
         D81VO1hqfi5DgGI26U62J2TdziGlgHSEI9JZGGZ27Byq0GbkUyWfwEY40AMfPuIc/PqR
         miZMv603b2ZJ8Ao7hYN1wApy4dynRXuc23zKY60yOR+sXyt2Avh5yoHoPPHb4rNegHW7
         zGJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MymcqnZkHOqjUJcCaTmpmg9eKweEy9UxXP0OOYlsdYI=;
        fh=VswdUGQZcwDqTPDDY8Lz7MwGqpBXyQl7t1VlntCJx6Y=;
        b=kTcA72t1G2XRHh+tuJcUAAQI8HqfEWJkxfAf25Ux4Syzgud649zsN2kyWfydE4mu7f
         JZjEkXoxDp6btrFxBhzU2B0mgXsqLL0kJ2QMBExhhnCkjoKfQwhB5Wqcvz67OnpXnxDt
         uqUri2QseTxuAABbh9FxYxv0J7IcpbI2wAuvPO1n0jnJKflrV5XkT5ruvhBV1fPJRtYr
         oTklC5nmbtHRTuYM1yKSVKHyfwYlVqeQTobWXpwY+fbPYjJnYNjDA5cLD+rly4xnYJwX
         /bF/NQ0FiCUr5N0PDNFA9mMCOQ54neE/v+YzPEJAdeCoKrwJ0+7+MfGuk5D6xvUzEgAe
         ZNtA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788514919; x=1789119719; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MymcqnZkHOqjUJcCaTmpmg9eKweEy9UxXP0OOYlsdYI=;
        b=RyDT/8MKoEkDnaWBrCz29P/QGTipLbDhtmiGv2nNCdr1cvCFY8AnA/H50+Q+9DPDT0
         EhsR329e+C2hMEhYz0eaaYtg8BICLyxvXDTMspHh2J+FVZW67gzCPrpaelnbHjUdHuOp
         sm6C1Hl3oLYmXg6PP8vS6hx7cvvgx/ZIAMA9KKKfnqePFDy2cPaIoZfSRoabqf9nS/m/
         tCyT1QylgPsq81q9yVzBH1O8cM7lQhLnGDNcj1unYi0mxF2+GcRVRCw0iH8ZzGQubXfi
         ZB8VFIyHSXUS8/WXqztXLfmZOAX82OyLaVZhSXAipsAs521LLfZqsCurDooxtmFuZsze
         UHAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788514919; x=1789119719;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MymcqnZkHOqjUJcCaTmpmg9eKweEy9UxXP0OOYlsdYI=;
        b=PoVQHt6pKp34P7lIVw8Wa7s7lx4tXWH0djlCIacblt0fvLj174pN+KPFabQv+tGeSX
         oJoggzvhffYawGETtQc6fyOPBilKbHPE9vu0Xi1u/maQdB/bAyxAVc8tyNtD0XnnNof+
         tiX0wkpVHc/tr0F/0A/OTv4+gS9cAwne8qstitmmarvN0yvveQIu2bimsIzVocUNh4jG
         BnFt3FjtahaD2FFCkJn20LhtNIvmLFuibpggHs+KUx0NmLCukwedm6eOZ3BhwsZYCSTn
         c5+RzMBqY2Lm8xWMdYEnzQ7o46FqfshcX+f70aLRU5jSuhY0RnGuhezhYOboP9xNaaEC
         m+tA==
X-Forwarded-Encrypted: i=1; AKwUvBy/Y6HaXKygA4Ps5cCpx5eBlZfXYE4FSvoYpKs14DkPC2DgseOoOsxke6mEQdqU6OF8VcihHuOxsQ8=@vger.kernel.org
X-Gm-Message-State: AFuF++nyVMt1LuKaFTejhDjtXQ6OYXei7oLUYGO6pp42JHjraxS1PMjv
	G8TeT9xHtpg78SeSvv8DhlyYj0AgnP5RVcFxeVgQzprOF2Q+3iL1LpuuZqidVDYAZT/4ATYgWXM
	n2DiRhUOo23Evr6P4pC11X4/j5uasdJOHYItWK/PJDhEC6XAEUbKaI42u+rTReshAGV+ZgpcF8k
	Zu+VdXFlOCWV3x2bFQv9JajCVcpm4QcBeRSY49LWJk8Ygtcw==
X-Gm-Gg: AYBFou1RTd1OGFfykU7z3AJp6KjWUw2QSKLrlFqZWbY19zIZu3qjiVbDKaxoYQufEjt
	nComXBp6GSjvcxz66a5yos6NGR0H5Ei9i96XQolQdoK/G4MZAmft8xYAjFbLgZqgfo9qQGpRUo6
	mGSg8c7A6fOBwbovriBUPRbJ/yOhMWwU9Wo+pYE1uYNfbr7TNlvY1NNMFFZw==
X-Received: by 2002:a05:6a00:400e:b0:84e:e741:174f with SMTP id d2e1a72fcca58-861669c6df9mr7906451b3a.7.1788514919166;
        Fri, 04 Sep 2026 02:41:59 -0700 (PDT)
X-Received: by 2002:a05:6a00:400e:b0:84e:e741:174f with SMTP id
 d2e1a72fcca58-861669c6df9mr7906397b3a.7.1788514918708; Fri, 04 Sep 2026
 02:41:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260807-am654-sdhci-v3-0-acc91d7d7e50@bootlin.com>
In-Reply-To: <20260807-am654-sdhci-v3-0-acc91d7d7e50@bootlin.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 4 Sep 2026 11:41:47 +0200
X-Gm-Features: AcwNN1WY3Q65S3OXvIJFG9cyzWdBxYBgoNhzeyg3bRWcOCH2qLTUuWKCE0IcBIQ
Message-ID: <CAPx+jO8UoYuWmKRi7ZNb=5mhnoeZB0iLHeqRqC3d+_NO1mx3zg@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] mmc: sdhci_am654: Fix DDR50 mode for cards without
 tuning support
To: "Diogo Ivo (Schneider Electric)" <diogo.ivo@bootlin.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulfh@kernel.org>,
        Faiz Abbas <faiz_abbas@ti.com>, Judith Mendez <jm@ti.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pascal EBERHARD <pascal.eberhard@se.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: JZMS5ke_HX3-3frqgei5YGnfybyg5LGN
X-Proofpoint-GUID: JZMS5ke_HX3-3frqgei5YGnfybyg5LGN
X-Authority-Analysis: v=2.4 cv=Q5XiJY2a c=1 sm=1 tr=0 ts=6a9a9267 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=bC-a23v3AAAA:8 a=P-IC7800AAAA:8
 a=Yx-hDG8L3HprUginNkQA:9 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
 a=FO4_E8m0qiDe52t0p3_H:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA4OCBTYWx0ZWRfX5qjqWVp9Ep+i
 bBxilbucpH5JW/IECtVwXv0/wXx45Fck33lYcL3abBb7sQWr7xg5DZaggPgWdi4BIvcE4a5du1A
 24987ZVp8HAQjyWsH7fVyxssvRfN8bV2U5CekZL9i2mGdZrsa+4uO6Gqvjhcs3b/DDsZpb11BlO
 fLBHzdcHl9bIrAkJ4GkgDw2UQ8CVXrEM2yShZtQ6TwFN1zvYpG+fXOG3gbbtTLG0n4lz7dSycN1
 /+/opE35JAmnFCS+s5ydz/zSC6cCv0ZjrZIkhVqVbgeFD9pYMEhmnfsoY8zMxUabdJYWNanx6Vk
 fjVsqKgxtlrUlXn6cXPokAHnqR9R2xOWT66ldnx+WCKTvoctbfnZJQtY17DNnvzWOx9691ueEc+
 2knb1FBqqXfAWmVM/M8svS2qQV9vx/Iq3gK7c17jzcFOKS8Xx9XdP4avDW1QDZ3aiAf55DZM8il
 aHgHuMYbzOlbbbR/8Xg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA4OCBTYWx0ZWRfX+vh/A4khHsxg
 QsOrNlzVrVnJBYPKQejhJQ1rKu7eMqzE9zI0vf2AXqC8gHaOU1jxgLtfYVrIfb9/KDbDkMFgl4s
 nAVfSbYFesUjgosntaw4xHqD8dUPus0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 impostorscore=0 adultscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609040088

On Fri, Aug 7, 2026 at 1:08=E2=80=AFPM Diogo Ivo (Schneider Electric)
<diogo.ivo@bootlin.com> wrote:
>
> DDR50 mode is not required to support the tuning command CMD19 by the
> eMMC/SD specification, meaning that calibration may fail on cards that
> do not implement it. This series fixes four issues discovered when
> using such cards:
>
>   - Patch 1 moves the tuning_loop counter from a persistent struct field
>     to a local variable, preventing failed tuning attempts from depleting
>     the retry budget across calls.
>
>   - Patch 2 ensures the command/data line reset is always performed
>     after tuning, even on failure, preventing stale data in the
>     controller buffer.
>
>   - Patch 3 clears the ITAPDLY enable and delay values on tuning
>     failure so that leftover calibration values do not interfere with
>     subsequent I/O.
>
>   - Patch 4 falls back to the DT-provided itap delay value for DDR50
>     when tuning fails in this mode, making a best-effort attempt at a
>     known-good delay being programmed.
>
> Together these changes make DDR50 functional on TI J721E SoCs with
> cards that lack CMD19 tuning support. This second version addresses
> all comments from Sashiko, which I found to be correct.
>
> Signed-off-by: Diogo Ivo (Schneider Electric) <diogo.ivo@bootlin.com>
> ---
> Changes in v3:
> - Collect R-b from Judith and A-b from Adrian
> - Add debug print when applying DT fallback values (Patch 4)
> - Link to v2: https://patch.msgid.link/20260803-am654-sdhci-v2-0-a5ee5be8=
6133@bootlin.com
>

The series applied for fixes, thanks!

Note that, I added a fixes/stable tag to patch1 as well since the
other patches depend on it.

Kind regards
Uffe

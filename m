Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AE64E3237
	for <linux-mmc@vger.kernel.org>; Mon, 28 Sep 2026 16:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790612055; cv=pass; b=tVHBxQijQNshT7gEp7QI+Gb283N5U5rGmyFKyvjr0N8TorwVv2kLb3ysTR9U9vodsS2OhDXNzNN1hovafBTrnTD9zhlQN7X3AkSkItA2rOK8B8fUqThITPVWNEdUlKDQAhf1kzNNwxFot/Sxn0FghsdH+TTiYNTlqPka+jWjLag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790612055; c=relaxed/simple;
	bh=JZrEgd0TLPwwAWCZALCFROIvTyPGgE4V7ttomrPypCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GXpEXFSlCrJARr/SevuZ2biLepQnk2r+MZQbyrg9/9EGwZJURD6VTrieAp4kBrdCI9B4w1pGynX6oJ76a3fgiOFJIQYWE6e29Cb1tFbS1TQ5+FJ+cLhoLUSl/qnJTzRAQdR0GPsCGcF3uBoTw38LqB9SKe7+zD3f+VyDlBGiWGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B4B6bjhO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XZB03w+A; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B4B6bjhO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XZB03w+A"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SEe1tT1017143
	for <linux-mmc@vger.kernel.org>; Mon, 28 Sep 2026 16:14:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1wuLslc0BDrZi02F93pW5BHjGyELyU9LG00MwdsNCX0=; b=B4B6bjhOrXYzpHS6
	c7x+eABBtfb6mmLt+lD2xBbcvKtUexKJeERF8k+o/wrVw5H41nTTcEXC+YRxIh42
	hLurdCnymvnOSt5+7W9puMf4iaDR9PkfIjp5iUGwxT1XEnKOsJKFlJj96xhFzdHg
	6bRkro+P6Ftim37Ou8YpRysMw4lmU33WbRO4lE8OJkYhA8M1Wp0pTjLrcg2FfLJ8
	EjPW6E+D1LK57zRbKcnv7yhwWuyYP7LFRcrh2ggAQy2VpoAeqeRPkwWiHg0F1dN1
	lFuOfPoGmgpm3uT12Hl1uKPRgfFzxN7HESqZVA6jsUW21Hrm7MrUuahHr3gYPR06
	+abA2g==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyebq326u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 28 Sep 2026 16:14:08 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc4e496e5c3so1551399a12.0
        for <linux-mmc@vger.kernel.org>; Mon, 28 Sep 2026 09:14:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790612048; cv=none;
        d=google.com; s=arc-20260327;
        b=MnW3HacVx6KmCPfFhSkBg0c3gk0IKxs4bW3lGw0NlLzsE8CAGCw8Zw3p1G+UXn9Drw
         LKuG0oOV/EKp3AK0J/PVqs4Jszp+LLDLNDplWeHJCXvHMiob+doWQQUGzHSpFTHE0ICA
         IpjDCEXEFZiIpYg1Pd7nznJsAYsiaUKCbUmYJdiACD8IKEHd72OVAcnwSokhr+K7Mrtv
         yEwXmZDKV4tkFucy+YC/Xn1BplttkL4WDmfpohyguX/3lUOCdGH9Gmix9Mt3g1iiHLXd
         JkDj2dRxY90xhyl/BoiXbU/lhR8RRhGcxHuSKCw+6UWJa2vZj0rL9VP+nGkCehhvFJ0b
         hqNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1wuLslc0BDrZi02F93pW5BHjGyELyU9LG00MwdsNCX0=;
        fh=wQ1wZW9Y2Mp6im1vFwDAfYHQFSZi/gm1uEIG2cVHEHQ=;
        b=TWtmOBZ1eyVDacoWs8C2epcChe4x2v8fEBALE4l504SM0X9jVZV+M0sVBwqnWtskcX
         6euJje/8xKMP5QGC3ELQKnwhI4PAdX5RfYkeRwz88eOULEAfYtSXmOzZL4da2TwH43AF
         lmI8hYIUC+LOvmtC2p84/Y6QImP5lMVvUcPJAsRneH4eb8diA7XL8GFVCGpUulttxS3q
         8idvjmIa9crk07GOZ6YoAU0gG7F8P1y9aPUuPpZt56tI2BnEcLbh6/OUC8HT9hAON72C
         kVThFICorg8Nup/9aPqGpwaAmf61gKIkOljT8jL5KHyHzQIEn9ibOhBOFpvcxnBnG0pF
         mI+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790612048; x=1791216848; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1wuLslc0BDrZi02F93pW5BHjGyELyU9LG00MwdsNCX0=;
        b=XZB03w+A6Fw5R8dXA1rDZ9XJtM6+Z0Ygh8zgodw+mzUTeh/ZPK+yGeC3vzc5BfUe3O
         2S+PqIftVJdagfyeXK8gHWJp1SKyGVFPQc0fdcMxajH6QMBsdN4jUqFkk0foaASOOk44
         wmLn8YFH92f3YSlNHOcWC8dWDUQczHfobJFJfV6YCqBbbPCxptligqwyYQNJG8kGKX1X
         QZkuR7GeZIWMeKJ0HZ4hmq+cbyUCb4L/WQY39wE+ZGPegSl23dQeKYaOdKpCsc4553A4
         NjdoLo7I0TafHfVcRwN1E2FTTEJ+lnK/hVHq2e58fpVOldtcpLt0gs6jBRMo+TWyH25W
         mNug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790612048; x=1791216848;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1wuLslc0BDrZi02F93pW5BHjGyELyU9LG00MwdsNCX0=;
        b=W3v18ZyHVhYo8MoOK4H2/Bp/Xe7a0iWkfvj2Xh/c1TddtgIEU/8/isWps8bzHj3SpV
         VJjIqj8Sp8mtl6bakVwhE0RJer5FmFuAVpDCjmsFmFjb4BqE1vaGMlfzAGHyPn6uve3G
         JkT3MmCX5wNdLJvriZz3ytgLOVoDm3C5mOClkycv+I2Duh170K4CP+YT8XYswwnJkrsf
         EZVBpC3CIHAKJCccQSb+ZY8BNElxKPYp6NWq9lsw/4vp4x5FKT/p6kCUJKufDgW4o3mq
         FKPE6+yFb1ISz4QyA4IUFXjMLuDqjFEDRhMveQWE9zwHiI1RytAvL6YXxILDUCWB++4p
         +ARQ==
X-Forwarded-Encrypted: i=1; AKwUvBzCnGq1GnlDJIXI6qsFq82t4RhAw0+m001wnPWmhFz84uRj9J4zVK5SoW1ymdm+dx7o2ATCQh4UyDo=@vger.kernel.org
X-Gm-Message-State: AFuF++mjA6cE6BPdeLBptwUR/x0wEEefuNoZ8WMK+Lccl52ZgbPNo6x/
	V8r1KssZyrk2hn/4TmCZU52FvaNvhktAfKQeQIGy9ho5zSmgmHDmc3pDQC4aCafp+EvaU1MhjsD
	45FO+M5Knn5LDNdHcqu+osQzk+vII+fahkG6iaTnXjsGdxJgEfmtAjQoVkyiaZE5++RoUw1qq9W
	HQHQjucQd5HH6AcXpSa6MSeSguf5LpNbixjY0AYQI22lcSRg==
X-Gm-Gg: AYBFou3QXP1v3u5Qdu3rR9JD0WtNPKJkF/5oq64Amn2Dm5AmbMa4R9EtFnaHzIn3dXC
	0aUe31e9H8ThaZnocjvc05gBpSAryAljRyXCNpVeIjmuO8ZK1cXkEH05fq9n7pmJD/ZGEiZ3jHq
	8lyy8woXNyD8VZ1y+Iw6djZefY4nvLWv+EWmHboSLJRzuwM92jcrAajwvvLQ==
X-Received: by 2002:a05:6a20:6a1c:b0:3de:73aa:2f2b with SMTP id adf61e73a8af0-3de73aa9171mr1434091637.52.1790612047540;
        Mon, 28 Sep 2026 09:14:07 -0700 (PDT)
X-Received: by 2002:a05:6a20:6a1c:b0:3de:73aa:2f2b with SMTP id
 adf61e73a8af0-3de73aa9171mr1434059637.52.1790612047053; Mon, 28 Sep 2026
 09:14:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1789634917-143165-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1789634917-143165-1-git-send-email-shawn.lin@rock-chips.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 18:13:55 +0200
X-Gm-Features: AclHuK98aGviMqkImxacCy4ZgSVRsVtZ24T4stkM7PXeqWkoom1s1dsvToa2Wlk
Message-ID: <CAPx+jO-O7wQBzQ5=zR=LS5Dbjew9v62FkjqyP79KfBZF7j6OTg@mail.gmail.com>
Subject: Re: [PATCH 0/3] Small improvement about mmc documentation
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Ulf Hansson <ulfh@kernel.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: ugF8E7yIWiEeB_2YQCfHh1r-54MNLOX9
X-Proofpoint-GUID: ugF8E7yIWiEeB_2YQCfHh1r-54MNLOX9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA2NCBTYWx0ZWRfX7z5DAltY2OEs
 LAwyOtzy5zS4txkNuvsWGQWRmktj4qGqa6SFUriHiP+YqHGW5T/RKYHwOX2vmnZh66wIVZS+1oK
 cCmUIeWT4inmEF4eJBnzJCaRkzP8N2s=
X-Authority-Analysis: v=2.4 cv=EqRHPicA c=1 sm=1 tr=0 ts=6aba9250 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=s8YR1HE3AAAA:8 a=s17Ks7xZ3G42BXOKHecA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA2NCBTYWx0ZWRfXwZ7opCR1nK0U
 Z6fm13TazpJhHLFeNrXutYFAz92tQgfGJmLXcuzO1/xPLNtHKqYz/9GtIvKC7m6JFgk5fqsMTWK
 OyYxJFhIOGdhhfPTlgDm/05U0ubBLyddLKfPcET8fJ2mTizEOme97lDidp1sNXKPhZWQpBJDFnr
 eNt8Z1hVRk8iqoaC8zh7Xm3ImwXGarvJCjzGdvlzAjDDVHGkV4o+e/Xqr+XaGsD8Xh4+mix5yLK
 fW+SCeRrdNoW4zc1ngrftY+EXahym+97aiyWdZU10EZpmIQ8of+IoQdnXMDIzuGRBAI9z13AD6a
 RFU5zKoSChTuQftR1TL6dq/ZaIDN3i/XE91y/TKbvvXzUfU2GzZQe1h8DrzX7mxz/SZt+0VSiFA
 tXQcA6Qsuf563IN4EM6BNPJleSlqpkolFSe4Hm/E3TBlBrleoWbr3dgGPYKrNp9H0LHDg7gTr3R
 ACbfhlWr8l1nk2AapAw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 phishscore=0 clxscore=1015 spamscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280064

On Thu, Sep 17, 2026 at 10:48=E2=80=AFAM Shawn Lin <shawn.lin@rock-chips.co=
m> wrote:
>
>
> The first patch adds a line about eMMC health status in mmc-tools for
> reference. And the last two patches amend the stale comment and link
> for both of mmc-async-req.rst and the code.
>
>
>
> Shawn Lin (3):
>   docs: mmc: document eMMC health status support in mmc-tools
>   docs: mmc: fix stale async request documentation
>   mmc: core: fix stale mmc_start_req() references in comments
>
>  Documentation/driver-api/mmc/mmc-async-req.rst | 64 ++++++--------------=
------
>  Documentation/driver-api/mmc/mmc-tools.rst     |  1 +
>  drivers/mmc/core/core.c                        |  4 +-
>  drivers/mmc/core/core.h                        |  2 +-
>  4 files changed, 17 insertions(+), 54 deletions(-)
>
> --
> 2.7.4
>

The series applied for next, thanks!

Kind regards
Uffe

Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794319421;
	b=TzhQ65lgc/YBtUuaAHdQToD4bJkA3gNGxJHmCGP3aDv5R2SqCXVn3BY/75GhvnSwzcTq
	 MVuqQseOLXGZpopuiHhMK/3YBpLaKSVDuAEp3aKC/DVfNj5NNujLmwXckDv630ojgzM2F
	 u5AGso4SCoxdul4RIl5VYf2bLHlYTM7XKVf73K3YJveB7VRY3YiWhUl8kF35YrS6hMsg3
	 5Ow+pDCnBgRj+J4Y7S9Cl67vczQ0e6ENPNasBL6IRYYWbgxV7VuVfrUt1+PzxwPLWp4ro
	 ewraSRSObL8TGwqq4CVlo6NOyHvYPzsvM1M+ofgeAv5XDwQ5QN72yVpgdo0lpha5orA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794319421;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=dDX5RY4IsH57J/4XqqE9KKM+HkzFDQFjq5zuAjcxbQI=;
	b=I9/B5LVdYa95CzADl0ttza7fFGDqBYl59XggqVRGWMpN7dq+2fwHQa1RKLPx5kqbut2K
	 ud7AN58WlPta8rcck578YmjZL6HM9+sTSEleoMTiAdBnXmSgAsHsjdFFqYjzL2ZWNxOfo
	 KJ+J7ICzSAAjQNyEHiz8SO6p4S0J658W8eKfbtnT2pPCoIFcrP5eUV+PKJl22eyKyWu97
	 jIPjuyLP38NLU3xeL9DQaNpLdlt57V2ZQfAATrm7kMRnGvmZ/rFJIwTi0MARyw30PhyCk
	 O35wMqV2aKQwkP0gWn5jU33nh4qJZpMewCtOprbXAppktAwe6PM0Qtlz0qGbxmfhvbQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KgXOUwrI;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TRgeo6Rw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE9460A261D
	for <linux-mmc@vger.kernel.org>; Tue, 10 Nov 2026 14:03:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFE9460A261D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KgXOUwrI;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TRgeo6Rw
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AAE3WeF028692
	for <linux-mmc@vger.kernel.org>; Tue, 10 Nov 2026 14:03:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dDX5RY4IsH57J/4XqqE9KKM+HkzFDQFjq5zuAjcxbQI=; b=KgXOUwrITrNNU6Dj
	/Yvq+TrAEK8YKXw+BevwJlstrdE99zvrKFLzDpy8CbkA1NX7B+2G91rwfRmXqPQL
	JnBY8RsWq4K2koAAMPHerYnf59uXqkU9f5ir7uppKQ66lXEGzJrw1JGH/rtBU0LM
	oliZwED9/Gtpe5El2/JmNAaoMIY/sXP396QBPsZloSRMy9p45P6ECsV4OYXTCZSv
	xURwlcr3ghHSjdIST4UWCGmoK8aXG1QqJFKHZDMd5SK+iti6+FHzKJZKVY4N8hzS
	+1Ezy93APlrNaAC7yJ89394ZUMtu2pD7mIi6JhPFfvxTO06zg5K5+B/lSa/nUhIZ
	+g0mMA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hv4pv801m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 10 Nov 2026 14:03:39 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2eaf3f829b3so17181505ad.3
        for <linux-mmc@vger.kernel.org>; Tue, 10 Nov 2026 06:03:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794319419; cv=none;
        d=google.com; s=arc-20260327;
        b=MaG4AorPs0GXLpashgxCW3RSGiPrqW1ZBRX0DZlJgyTgSBG6g+nowmQ6FFNSacJYXM
         vwREUfE7LUZppJumBhF6FfuZ3qJyEmWOwTzL73M/FOFusrGnMrg6KPRM9zklwJ1TwCw/
         0jtwPGtGM1zE11iG9JtVu0GxlsSMYaz8Ov5x8zHIcd4Z7O5dgc8dFULWYifwzWFU/FRi
         FtFZuzxHIyhyGcz9rsDFD+NK0ORKcB+/RTUXI26TLoObYDFlUa1E4Dp94QWHgO8ny4iQ
         vxFdzd7Qcttwj42+HBYo4ki8mep9+TpRbuwboMYjz58LX3EqP7AY3f4UxM7pXXhV2DoU
         yb9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dDX5RY4IsH57J/4XqqE9KKM+HkzFDQFjq5zuAjcxbQI=;
        fh=Yz8HxecZLzpFHLj2ajPyWSeH0kAGAtkUsiy8ITtbGWI=;
        b=HfTmQV75ekrBWVkQWan693DnB5yrUooWGF8Z13//Bfitb0cu+vVcwJ7R3kTSvad4co
         NKw/LavGqjdzfIRc5mlQ26p7ERfwz9nqid0CrMsRG/gTtCQlisvtR7M0hUGgt+qfbywt
         85x+1wEBLwVlPfoyy5iHJkszZNdzfIh7sTIl3a3sJsLb0Zo9y/fTE8skYrnGToghm9mv
         k2Wr5DqCt11GPWf5OVy/9pQDB1x5T9hriVOYElFIrO4YcEucWWyHldUgzNB1g0r0SNDR
         FKSlCk5olumiL9o0IUZvbqiyQGY5if16Rkoqt0ghhYORCPDagac5ppSJL+bcOz0KTxxp
         ipVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794319419; x=1794924219; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dDX5RY4IsH57J/4XqqE9KKM+HkzFDQFjq5zuAjcxbQI=;
        b=TRgeo6RwEHSsA2/xwLMsO8yEk6Vm/2bcK5XT3poRWGF+sKb6KRfMm5tAg90mxLiJ4Z
         +CS+Ku+3CUnLMopKYwyxdXUu8jl7K2cJ/aytHhu6XEPN2OnZxGvqO135FE2VeFB7jacg
         qlXyI4T11RbFO4M8BQQFCzT2SQ4gd7sl2PaRXFMrtg4R7Q8OeEIKKVmiXV7JonctTC50
         ljsFCBPgYvggl2jHRGTgT9aBxAHfoq2nmH+b2hzZwAZHP0h03T90l6GedY/C8pxEScgU
         OG5XoTQM5HRu9S4/dvq+LxyfsjbHoMMIf7+mXH1FnOwwenCoOVjir/gcsW/HCo78UUYw
         kfcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794319419; x=1794924219;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dDX5RY4IsH57J/4XqqE9KKM+HkzFDQFjq5zuAjcxbQI=;
        b=2yOke4z2LBdcLKfut1P/31KYmomZENn9zz80dd1iqRzGhFsf1WTxndwbsvA85XivmK
         pBwMt04nFgypgfLYOjKnDU5nadekPtKohrM1e7PHecmZnI86gN+73rTS7cGuMs8MNv+V
         BnOUuHbbXNEKjICHxFLom8Bh9tyGflYGt+RDcgKJCAKT8ZXcDpl5+WL7V7HzxkPPC9zv
         UYSe5Og6gKHMcer2ufCkB7yhaSeWJ3Vpz3gWvv8td6OQMTpz2ZagRJxQ7Y2WtyGR+KKB
         j1DVzzDNsFQkFLm8vEdwxZhe69Cdfn1L5g/jI3j8mOaqD6RZfYAZXmjXthKjKvpZubAX
         aSgg==
X-Forwarded-Encrypted: i=1; AL+hErEmvPVfqHDlzzzDXqr9Z7m9jlge7yiZkyByLM/QsY/Gr72GnZSh1BmAFuDFTvknf7XoA+4Sdrar09k=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Ei4MSTX+Vg3FUY6Xz1umBeVSD7TuFKD8daKktz55GtC41ABjk
	M0be8+aL+NG2ktKU2Ag+ubbTndK9rwvPgWEIAP401G4/QJKKrH5LMBgr4DMygP1t6hwSXIbNXoE
	F3Ik7O670lgb7PbXpS6Gi8wIzseedDpImeqRPQgDT+RyjItvZq+vpWTI1SQARIP72Vat5EP6vhJ
	itlLnYX55lAY0rmude5m09st7mMKdZcBZzLaYyPQ==
X-Gm-Gg: AYBFou0slthGX0Y0rBeCIqqlut17p4QRJ/F75QrLLT+MDmPwOZm7EGFNNgm8H4XbOEl
	r+T7nKxnS1ew/xHrv+48XRjDKx+cqjSEXIMaFsJRlfqZWKF6I6mHS/aTnGyh1+Ep0q3L1gF6uHG
	bGGOACqJGuykzHyp8fUkMpXKVmrsGZsXwrg5fuCUgNDE7pntK3zy5+nzq5fQ==
X-Received: by 2002:a17:902:d547:b0:2ed:218:6043 with SMTP id d9443c01a7336-2edb93052e6mr21107265ad.59.1794319418779;
        Tue, 10 Nov 2026 06:03:38 -0800 (PST)
X-Received: by 2002:a17:902:d547:b0:2ed:218:6043 with SMTP id
 d9443c01a7336-2edb93052e6mr21107095ad.59.1794319418328; Tue, 10 Nov 2026
 06:03:38 -0800 (PST)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261101063719.88570-1-0xbeac@gmail.com> <20261102022924.51343-1-0xbeac@gmail.com>
 <20261102022924.51343-2-0xbeac@gmail.com>
In-Reply-To: <20261102022924.51343-2-0xbeac@gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Tue, 10 Nov 2026 15:03:26 +0100
X-Gm-Features: AclHuK_Jj5PX-_n156Je1b1cz-aHL6EQj5fE_4gj1noerQIcKZbFTd5LaBqKoz8
Message-ID: <CAPx+jO_-6R2N_Mf0AjsqVa==4fQAf2hoveOsR6RyY8zVxrPbSg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/2] mmc: dw_mmc: drain bh_work on host removal
To: BeaCox <0xbeac@gmail.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>,
        Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulfh@kernel.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=XqZvqlF9 c=1 sm=1 tr=0 ts=6af3243b cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=J95AHcnkyf1SBl47ZhgA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: FTT5VPFSBj9CTOhqExsqumk5UV_mDxH0
X-Proofpoint-GUID: FTT5VPFSBj9CTOhqExsqumk5UV_mDxH0
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA1NSBTYWx0ZWRfXz3HMbhJgFQiM
 tiP0Uvn36yH9kvqKKtvBwHGIt07XCBZGLPxwRN4ag843EGKLXIZj7/yxe/F67vCbbkjfHY8TmsJ
 F+EY3t5CUrloGM6Bvydv5QZTpXK5RyQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA1NSBTYWx0ZWRfXxpT1PkMRcSMx
 04Z0fxZrFxEUp441ANuwYXnECPFmhK4NzoGi6qsfWqBLGZf+9Uxnsiu7g6Mnoh61TUXQfJTqH8a
 NKNdWSQtQ8SShNIbNbhxp1SvmqkMAhezcnWopDRcgo/tr14oabRdD9Q6WnZYopZiBnWnNTAKUQq
 mlIRyWFZ3OKq6S4/jJB8lVg59sFREEmW8tK0a2FtjvXnNpQI8hsZIsrYcX9KmQM4dqwN/kgNMIz
 Kzjkat9SlrLhqUVTgNLC+moTjAI3+06YkFcFKboI89DQPM+ZJoZmwG0zKuAWPhyjknn0EzdddeM
 9eJJCkXjtdElcfuH62qEklxROw1He69j1zjDeJLjzbl9gmwuZrszEUOesDCaUhypoERT9WsJfsP
 TXSRjkXzkxanfjVjjwdb2/iRdMTnwLULUd2/QVZzjwK2fJBe6EopwsXv7iL2Zr005IPpWOLcBkY
 wUJFoGJykS82Qc53nLA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611100055

On Mon, Nov 2, 2026 at 3:29=E2=80=AFAM BeaCox <0xbeac@gmail.com> wrote:
>
> dw_mci_remove() does not drain bh_work before the driver core releases
> the devm-managed host.  The interrupt handler, the fault-injection timer
> and the DMA completion path can queue that work, and its callback
> accesses the host and MMC request state.  A work item that is still
> pending or running after remove returns dereferences freed memory.
>
> This is not a regression from the tasklet-to-BH-workqueue conversion.
> The tasklet that bh_work replaced was never killed in dw_mci_remove()
> either, going back to the original driver.  Commit 921c87ba3893
> ("mmc: Convert from tasklet to BH workqueue") only replaced
> tasklet_schedule() with queue_work().
>
> After removing the MMC host and masking controller interrupts, drain
> the interrupt handler and disable the work synchronously.  Disabling
> the work also rejects later queue attempts, unlike cancellation alone.
> Stop the fault-injection timer after the work callback has finished so
> that it cannot rearm the timer after teardown has cancelled it.
>
> Fixes: f95f3850f7a9 ("mmc: dw_mmc: Add Synopsys DesignWare mmc host drive=
r")
> Cc: stable@vger.kernel.org # 6.11+
> Signed-off-by: BeaCox <0xbeac@gmail.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/dw_mmc.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index ff0b25d..5b47643 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -3406,6 +3406,11 @@ void dw_mci_remove(struct dw_mci *host)
>         mci_writel(host, RINTSTS, 0xFFFFFFFF);
>         mci_writel(host, INTMASK, 0); /* disable all mmc interrupt first =
*/
>
> +       synchronize_irq(host->irq);
> +       /* Stop the work before the timer that it can rearm. */
> +       disable_work_sync(&host->bh_work);
> +       dw_mci_stop_fault_timer(host);
> +
>         /* disable clock to CIU */
>         mci_writel(host, CLKENA, 0);
>         mci_writel(host, CLKSRC, 0);
> --
> 2.43.0
>

Received: from mail-qv1-f67.google.com (mail-qv1-f67.google.com [209.85.219.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F419C2D8DBB
	for <linux-mmc@vger.kernel.org>; Tue, 10 Feb 2026 02:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770690322; cv=pass; b=lJidpilz3cVcG3lxIAPuQ263bi9H16AGPv0VaI1N06cXI+yKoaACPLg2h84WDAE6t3BtxHa+EhMpRq60TKWEMOabEEwlotLEVwafg7RH0HQs6D1BrGgnleFZ5jOO7C7jp7re3tgEDawRh3hZb5MD2Ta2iVpdwOrBm4kAGWDhvDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770690322; c=relaxed/simple;
	bh=0IKkjftBZ/R50NnZDaGPv7Xh/Wbs78MC9w0GXSCbnDo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GaaCVgDGM3wPbbsYkkLsstzDo6YvUsIKoVVTCGxoN1Car034I58FbCn4NXrqilgQcKY9RZlUEbm8hk891L/ZCdTciqUlQfLhJr9lvgPV3uga2DBWGxsam3cC+3xPWloZKW4mDpgdnYwJbxxgQPe1IYaX3r7kiQvXWYP98TdMIgg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vwiiuzuu; arc=pass smtp.client-ip=209.85.219.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vwiiuzuu"
Received: by mail-qv1-f67.google.com with SMTP id 6a1803df08f44-896fa834290so24892726d6.1
        for <linux-mmc@vger.kernel.org>; Mon, 09 Feb 2026 18:25:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770690320; cv=none;
        d=google.com; s=arc-20240605;
        b=fIgygHH5iN7MP79/NRvxORv5pEfvQ+xa72uawoQGUOxI/K/MTdwN7gTnySb+oUk8OP
         ZtCQ2kZgwaamht1BDfcJi8+WwdhdqpEMrIsEFNf97SbJXv/CJi9wOh7HMLMvHfS4vCQY
         z3i7PIgEdk1tKtO/WE6zmyCWYg5o0fInbjmFrEgZ2GW2Mg60ibVMq8UGBeLV6Ra32m8G
         p1AN3P1hxgdiwFCpiWnfU0OI/j22gbl1tNWT0WXKQKKig54Cl8igkWl//QgeE+wQoGgC
         xQ8379B2CCcXuFs6oKXY/vEMNcMlNwznbnPwKrDJqqfnRsqwSjVsI1ulJvj31sMKPUGW
         3vAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0IKkjftBZ/R50NnZDaGPv7Xh/Wbs78MC9w0GXSCbnDo=;
        fh=M7UOd/t5//Qe9QvEc+sgAdznt0bpWIM/Iw0CVNsYa9U=;
        b=bdSk+I16sZh+8p9+joHAz9GiDIVEJZOe+NaFi7Psj1Q7jVz4WsLkG+3xRM9MB/0wwE
         qHwcxGshG6VOedtDR51Ub1h/5HlAdP/xui4CCChUrZZvsJFmN7ryfAej6qvoez0gC85u
         YbwttMoTf+JVTRx0faghY48ggFi83J4yDTgDri51hF8XPJc5GET8iIHJG6cGopdluYml
         hs8zGoeXayhSUZW/J3P/467bgOWLBAfyUQ4mb2tvdcPqf5d+kKQidSWtxIbTEdsag0yw
         BzQ8j8YRyg4ZZwohShPMQ10F1fOyOqoCRiCcS5iiT511yA4/xwo1fQjpkDyf1dOo8aJK
         2BXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770690320; x=1771295120; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0IKkjftBZ/R50NnZDaGPv7Xh/Wbs78MC9w0GXSCbnDo=;
        b=Vwiiuzuuj9+4VIwVaiznd+ky/Dup7HfBf/46yRnsRyeaOC67O1hiO8V7bnWBUpdo3a
         cujCEuwFXlYIsZccIDzkHgIvMm5FVa4j52xjV2TbePxb3u+A4FuG8cL4nDeHaFAhkC7V
         DrdkWo1WRtaKen8VOoqbUAqraqApzAtrRLCIX5iwP1X5XWNffty50UzN7QbKHMKNhNOD
         g8/PgEj34IPDHSBqXeNrDjF/ydmrLJjmQ5Tu681duQYllWQCvAnem3rRuErMzYD7LiYQ
         RVNqwXd7jt16fLLotUXO233QKO/LSbvzdjliZf5B1KwPGVwnyNdiVtXnMXMDNhcfp3hD
         KkDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770690320; x=1771295120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0IKkjftBZ/R50NnZDaGPv7Xh/Wbs78MC9w0GXSCbnDo=;
        b=gfEqxyb03amZGe+AyU6E/qeB2rdXgLJvplUC89uFiUm/U1vs6Gqm9d/eXJjacGg/qx
         cwtKgGYQ9iN/e2UqWChnMP9T88Jo2rmQLDmbst+kQcBnate4oAGS4RHwUbk1gOkbejm6
         OA5L43s04UQiXYbgjqf7Y9eMSNOlbyoVzBl0kYbwwTdqeq/MvN8E9iC/nOwz8wUFiuEN
         3gFMM1tAP+xAWvIjiznfnokLXnbzPBJaCD1/ZGCNV719AdploB/kU62l5F+mya9U9Gdn
         96Po+duD/3gTyX8tnh+qMjdLLME7J9otkngnm1scuBuN8Jqxo/fktu6aGZF53CxmVOQm
         5gIA==
X-Gm-Message-State: AOJu0YyT+KYHtkVtK4JrvlgmF37eeU/g7kENOTryG9vxI41FekVdrrCH
	KsRPhX3PucHYCcUF0UnFkddrwkXWX3gVXFzNymaQ0WhONMbpbIOuSzHRd35WWgaeobVafLuyS68
	d9ljoWT08Q0qGiF4v1mUtdLbAY1GWd9M=
X-Gm-Gg: AZuq6aIl3QsKhzSw7c0mRaF1AvnN15nC45Hru5RSLyHvVff+1io/3ydLQsDMKt5Iahs
	JQuBFmn5cl7saR7JXgBuR0O1P68lTw1UiqjLM38a/d7nkH2VrQm4Ki6pD2ukLgzWBFso2dooxLP
	EjW4/es0hq7vPKRXL8F6URnvILgXUs11f58vspZ6xLqYG8Iv1Fjv78l2fq1Qtx5XegAg90Ki+Fc
	WNAC2Su1TqMf7+bDU0A7rmqSmHoaLku7JqoiT30NxBW65zSmAX6SreIoagOu6S7OcIYn5QAWlYr
	deEX7vgMdqPkxq/uihwecQGuIJ4Oz+EksESaKe1XpCNoWIYOl3JYL8+B/aHsc60kZ7Y7QnmXFp8
	AddM=
X-Received: by 2002:a05:6214:c41:b0:890:7f85:81d1 with SMTP id
 6a1803df08f44-8970d3dbbf2mr14877536d6.13.1770690319902; Mon, 09 Feb 2026
 18:25:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260131020039.45966-1-enelsonmoore@gmail.com>
 <CAPDyKFps1oX=aKuUYFbXNQXM3rGtZOwTfgCaiHgDvGOb3qGc5w@mail.gmail.com>
 <CADkSEUhk1TfJXvLYOrx0OvVCgCA=L+CEZXGzQAhdTgkKz3a=bw@mail.gmail.com> <CAPDyKFrfXgCZJtFHttA1E0Tn1tSugHWsSfZvP1RAOOx5=ViWQw@mail.gmail.com>
In-Reply-To: <CAPDyKFrfXgCZJtFHttA1E0Tn1tSugHWsSfZvP1RAOOx5=ViWQw@mail.gmail.com>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Mon, 9 Feb 2026 18:25:09 -0800
X-Gm-Features: AZwV_QjM0MYlLgT5VCVN2n4N1RhPAVZGwz-1CheD8P477M2pBEpJDPXC3siPNtA
Message-ID: <CADkSEUj1TsZLXNO-GPU-5c19RPV-9d8os9HnxVOxrygvyTtqJg@mail.gmail.com>
Subject: Re: [PATCH] mmc: remove unnecessary module_init/exit functions
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Jaehoon Chung <jh80.chung@samsung.com>, 
	Shawn Lin <shawn.lin@rock-chips.com>, Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Uffe,

On Tue, Feb 3, 2026 at 3:16=E2=80=AFAM Ulf Hansson <ulf.hansson@linaro.org>=
 wrote:
> > - They have neither init nor exit functions
>
> I don't think that's correct. At least this is my understanding of how
> this works.

Yes, it is correct. You can easily verify it - for example,
drivers/net/mii.c has neither init nor exit functions, but you can
still freely run "rmmod mii", assuming you don't have anything loaded
that uses it.

Ethan

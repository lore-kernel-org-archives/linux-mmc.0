Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.190
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794158658;
	b=svUQZ/bJTyVjKzD6+Q90036qtwYCeDK6CF9rXTkVQS4W8e2nnd7pzQuNL1PVw95fqav9
	 SK8GgLxxmYkOUDC/gfZuxhX5v9U9MxEBfxKAnZ/JzBZojaiFfk/LL/IV5dlJUDxeMdTi7
	 hfySrmKnKyVFrt2FlQ5dNAHcT0X6MOdHW2MP9fj4zw904zxW9iEafJv0vaM986sqamSls
	 glLp6+4u8bw1I1e1xxtdkQaSSsLn34gNhoiK5mp3QQGqrKC+XXXwJ7lUV4T+OU89YWeY1
	 EN8AEFsXsJ11aLaYQvreCkMeiCkBpuAvVswk/7QA9XeLaaIbFsHorwqUc2sErc89UEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794158658;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:In-Reply-To:References:
	 Date:X-OQ-MSGID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=VvJaEaqoEnViUr71CTvhKowhS1FsvhPnavq+r4Hkwmk=;
	b=1owK+sFB3B5b+tnO6d0IvUpYw6PXTDz1nTqmkYYUxWVxs333TK9Cz91jooI1O9VDwFlD
	 H7wgoG19l45JuqKOfPs4RXJ9mVemt4Yyd5Nb9H6B40eRv6XRzSnsDdHpXq0XY8pT7zQBa
	 bV5lSm4QDKyHuK2FglFm/J1jMa0skDq953sgiabp/+xEXbgqWF+S9LBhjHSBpypvz534y
	 qb3dVKQCN93vyulIx5BU8Q4vs2/kxQeFhA5WuT1fE6P6GXtGqYLaFY8qGeNM3MRCCo4Wq
	 baJWXyxqlvL4o6N4XjlGw9ncgb7nDibHAin+YYODU2+Q7S9ftHa0I+MCc0GmtkUiceA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=lOyeHcCg;
	arc=none smtp.remote-ip=203.205.221.190
Received: from out203-205-221-190.mail.qq.com (out203-205-221-190.mail.qq.com [203.205.221.190])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43495606A331;
	Sun,  8 Nov 2026 17:24:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43495606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=lOyeHcCg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794158655; bh=VvJaEaqoEnViUr71CTvhKowhS1FsvhPnavq+r4Hkwmk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=lOyeHcCggReQgJ4KX/6jpBpgmJrvm9K23iePZNSkzkqZHFiXj+GKlDHDutTPy5Ekx
	 qMQvlli+KUpi0fcL6hTmVa0lsS97IOHr6SBlJKoVuWgdLytVvH6liPTZMvNKcwAZuV
	 8BkXK/K3DNVcnReVIWJe/Yk7dMzIRgQvQVkX3ENM=
Received: from [127.0.1.1] ([5.195.0.150])
	by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
	id 5F906C5D; Mon, 09 Nov 2026 01:23:57 +0800
X-QQ-mid: xmsmtpt1794158652t9c6im2rp
Message-ID: <tencent_7BD6890250EF77B372A43EBD2807F2423705@qq.com>
X-QQ-XMAILINFO: MDbayGdXPuoeZf8uMEyzsw3f3RUSRxrjmzd7HmJBIfhLkycIWaKiQPZ5sf1wH1
	 oApCGJxIaVc/I2NfOWDQCapjFclfdQp5/4BWvNQ1v4UL5G+knUM8ISml2VCOGjvSJGYChOEueRUf
	 DRKDgLfvUDjLwecq9w8ruhpVp8xHboAyGrxFGPjuuRnPHeWiPjEFzJxvYD0b80b0v8WFrKL9lkS4
	 eM7vo86ZW4q1HpzYiSx/deX5l43I2Kxr+CAHtR8nz9p53lemdbAm3FB99nrcsdMkQpWA7XvbHj7D
	 xPICPkS+bR12dc7qbRpjFuyR703HuVxwSdecVA30tw689mZxzBdhB1St2HtW30bO1pg4zuGwtMCm
	 RUDMPtvHSmIehaTWSwfU3ipgsgkDPDp5QunSN/WNLtX0FSM29465nlNpOFyKRYaQm0uyWp1aPrfs
	 QCgDEh6OHbj0MGMKix3h/8n4E8fBCCHf1Hz1JsUk4Eg5KvmnjQIBUeFPOB17qk9m6hAFstZ/Lqki
	 DvOCVQxpa7Sv47ZAdyC803o1hdjSsDfCfEoMVD9j4FDoSy9D/5t9FvdL9JE7mL8eNCZRsYb8Ka3I
	 WyOv/jLw83g8PpL0eh/AK9LXV+OoedVmq/bTn6tvCNkS/e/hhSq3Tx+uM4RlEhAOLKJ6LASZw2l7
	 7fLk67koL7e3OCGixxmNnUJk38sYkoeLtcPg0HvK58Qw0MXxLcc8WFOkC82ukdAf0/UpTi73qN3J
	 Rm7ZD2gWGxa07+wGYCkV/x0OaTvI+ykrEN5NKd7CeOVQNOZnM7jeqKFHUFX6tP4LDXiMhsu5fpje
	 nS5tf2pFlJAgXQcm8VMMsUuNp835BccZl3iVaU6Bu6+zNQIvlrRhOOoVurAveuYJijh+hsTVN4V+
	 RfZHuII5YyljvPzv7OZRj/GCQm9CE64Tg5ZwbfYNlEUAhB00FtAw9adPwzsp0VTPOSoBWyz/b4oZ
	 69MRQfatT+asDvSrZBgDDwdNM8LYH9mz9MiCOglJJFTBwHxvHb8uY/nHivU2pjwwkgc/UVOg0kw1
	 f8glNDC7cydCpIygEaqXTjzgrHVhO+KXdel2mTKdKaw1ZJ8R5HSRt4eoVlHopo1lTxQIUWwQ==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: Jiawen Liu <1298662399@qq.com>
To: Adrian Hunter <adrian.hunter@intel.com>, Markus Elfring <Markus.Elfring@web.de>
Cc: Ben Dooks <ben-linux@fluff.org>, Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: sdhci-s3c: check clk_prepare_enable return in probe
In-Reply-To: <tencent_76880DF24877C8490B50E7D7BC52A55EA105@qq.com>
References: <tencent_76880DF24877C8490B50E7D7BC52A55EA105@qq.com>
Date: Sun, 08 Nov 2026 21:22:12 +0400
X-OQ-MSGID: <179415853265.5.36653500972686270@qq.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi Adrian, Markus,

Thanks for catching the name mismatch. I'll use "Jiawen Liu" in both the
From and Signed-off-by lines.

I'll also check the relevant history and stable criteria, and recheck the
clock failure and cleanup paths against the current driver before preparing
an update.

Thanks,
Jiawen


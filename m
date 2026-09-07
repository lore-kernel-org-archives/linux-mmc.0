Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7140146D096
	for <linux-mmc@vger.kernel.org>; Mon,  7 Sep 2026 11:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788779884; cv=none; b=Br+UoH5nQufqWJPAlK/ZrTUbrecHTRDl+tmbrpQE58QM/om3gAPA5hdqp1xXVCdswHpUqpdDcYEMTG7zS5O9iMDpQP2MAc5JIb8OeAHcBjaUZJiMcEPllR3KGZ2qTO9tFuoJCc1lEaD0onS9DuYhVRJbgMfW3HNpZKrYJ9phNus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788779884; c=relaxed/simple;
	bh=XYqEV1M0GpB+fKUY4FbmTaxiqGTleihRUV7J7Wx1cSI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ahWn6b9cYoVobjEkXomZl0TXwtxHmBnURJ3p1FCuwb16BBqAi5LolrMSpcO8Vjdf4fANt9c2oBp+XLJhnqWbcGjOKY2FHZZbgZ03CUi+a3nWzVWfNToCHsT0ouycOf1EwETusoG9WTWZYHS6/8Y4/7mTID0GLVYGcWdjMQMISqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TtGcz1qC; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TtGcz1qC"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48441a2ba1bso2438931f8f.1
        for <linux-mmc@vger.kernel.org>; Mon, 07 Sep 2026 04:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788779879; x=1789384679; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XYqEV1M0GpB+fKUY4FbmTaxiqGTleihRUV7J7Wx1cSI=;
        b=TtGcz1qCoGur1AWzOGbC7r+6KXeDxBiuaJBX7bCeFzbBUdW/aUKItYWvZoe7RsBYvm
         5TzIbCE5VynFN92BICU4PzI834qCfCwkVWOjlJ2JRlGbFRAHZRzat7IgXvviPgcGzwOq
         +QR4E7G2uEHx1DVbOh8lUNwrjTjEK/jiKTDR3GPQ94uw9JoO5Ff1AglPy2AYbn3H3ZQP
         JrySE7ss5NpUtZgqviEURQPaUdzZKguI7mY2y5AIe0U9KxZpf+GOgKwvmlZZKoXOZ8VU
         qnnVvSHmeAO0yfmbJ+Zn9mD2HSG8ObJauwJYpVa+1iONbWdWS9BKWTYY2T71npsfyhoH
         EAlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788779879; x=1789384679;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XYqEV1M0GpB+fKUY4FbmTaxiqGTleihRUV7J7Wx1cSI=;
        b=sCtbbffxCBi8dhqDpWs6LIF9nymuEOK+AE9IugqXFSxMWnaGiD8cxDeeIrCbbeJncg
         bQOjKVS9sb/0qGtsYEDawMTR1VSZJF9tBpeEcyS0UxfGxdfSTIaQB6AjVDqvYMMNCe1H
         K674ch1mvH6QVF+riHWg01vEAta6kyboIkFg7UgSkHaOzNF7ZFVjREV0DHUDFP56fXAf
         Ae6yC6QYWHWM1kwlHRNtFhRCaJOcs7eD3G93cItWvDb5O9jc4DRk1OiiFde4x8/HYvx+
         JxPozEGKfedgJCMb8724hZW2s6mz5Tgil7WeldyNBd5rLy0WTAco546xQpthoCB9VDmh
         aP3Q==
X-Gm-Message-State: AFuF++mrjfddtCMf4IF1e/8oGUGXAwDbca4wCGwMVlLRhF6jJukI6s0H
	AQ1yLqJYTuRLhWElWbOY1rd8FZv/36ZCYhuIDq4+uJuzT4jujXnGE/k=
X-Gm-Gg: AYBFou2Fc9r3om2MotTPb2Sqnewo9t8vPjAV6e4mm5MaIKKhcsIqFlW7K1K2d2wg+5r
	AIMJd7j0bQtFnXcvVF17UtUwdt8e0sO8EPHz+v3si+uQOGe06tXQZsz76pqldQ72PZMJFEnu2BH
	tZP0ASzkZWQyoKQRU39oCizybKCWHsWUalGs8QTTw2c9dFSUah4QvXVUiAhac9p8lb+AzO3eUwY
	4xpLE5fdQjLNXOajnyLw0gFCkF0AzVTJDVudd1HJFH6JsUBI52DeXWl60OjbbS6q3I2YlhFGwnI
	WVeOTqgbXHBekulrnlJ35IGVy+92CJZJbZ8eRmyaN0HGNifP48DgEyyp6IyEbT3EYghvsBFTwYb
	bR1NpEbh7ltmEkTQmE0Ytb7RRObjZm3iFPL6zDOdtuIEsDTGFIvgkYnS+rggStiRZ0jQPorgmYK
	gFt17esExgdJxZke0URpHwj91eT1X2v3Utv+ndfw/HeiMdvDEhCOEBZJ/Soy9VOAE0nkQybQIKd
	o0pJRZTI39vF+h91fc7L8+Cukvae1at5AKqvLGHF4VyqiIYmZ30nRjbNajk0muU1QD1kYEOIQKA
	nN0SD+LSCh5dnYOdUXrC5I0+nbjNiKwziNx4Ulj1GVZYGqsYmq/z3RJsWypl9Q==
X-Received: by 2002:a5d:55d1:0:b0:481:4697:8808 with SMTP id ffacd0b85a97d-485872dee4cmr22090578f8f.22.1788779879457;
        Mon, 07 Sep 2026 04:17:59 -0700 (PDT)
Received: from localhost (92-242-248-12.broadband.mtnet.hr. [92.242.248.12])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48591eb3d3bsm16032918f8f.0.2026.09.07.04.17.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2026 04:17:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 07 Sep 2026 13:16:59 +0200
Message-Id: <DL91IWM6YXRN.3892K60CVKZ3U@gmail.com>
Cc: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-kernel-mentees@lists.linux.dev>, "Ulf Hansson" <ulfh@kernel.org>,
 "Guangshuo Li" <lgs201920130244@gmail.com>, "Runyu Xiao"
 <runyu.xiao@seu.edu.cn>, "Shuah Khan" <skhan@linuxfoundation.org>,
 <syzbot+1ee4f3b9228e35f14677@syzkaller.appspotmail.com>, "Geert
 Uytterhoeven" <geert+renesas@glider.be>
Subject: Re: [PATCH] mmc: vub300: fix sleeping function call from invalid
 context in vub300_inactivity_timer_expired
From: "Jakov Novak" <jakovnovak30@gmail.com>
To: "Tetsuo Handa" <penguin-kernel@I-love.SAKURA.ne.jp>, "Johan Hovold"
 <johan@kernel.org>, "Jakov Novak" <jakovnovak30@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260816153809.7067-1-jakovnovak30@gmail.com>
 <aoLCr8JEYaYxcJcQ@hovoldconsulting.com>
 <61c4cee5-3c63-4b09-abbf-bf945b538403@I-love.SAKURA.ne.jp>
In-Reply-To: <61c4cee5-3c63-4b09-abbf-bf945b538403@I-love.SAKURA.ne.jp>

> syzbot has an AI-generated patch at
> https://lkml.kernel.org/r/49982079-95f4-4e8c-bbbc-bcb127e2f378@mail.kerne=
l.org .
>
> Please check.
I checked the AI-generated patch and it just uses the deadworkqueue in a
new function. That is the same thing I am doing except that I'm using
the vub300_queue_dead_work function instead of writing some new code
that does the same thing.

The real question is whether mmc_free_host should be allowed to invoke
the sleep function or not. Geert needs to elaborate on that since he
added this change in 1036f69e2513 ("mmc: core: Cancel
delayed work before releasing host").

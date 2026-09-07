Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AB5456E0F
	for <linux-mmc@vger.kernel.org>; Mon,  7 Sep 2026 12:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788783591; cv=none; b=muvvxsx2aBq6EaVSWM/kchk7iz86V3gm/u3pBkru2q3PigkEdxq5vvn9tJ3jvZYh/o5rhimet6fdDWnVfcbOpFgub3rsN0s6OlSTKpRxgjaqPq5E57xOcqeCD2pA8VmNOytpr1gwtOgsZ0dOUwZoo/vSMwtAuBlgCIpuL7MPm0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788783591; c=relaxed/simple;
	bh=8sWGG3Euclft4zNcorzRAt017Dh4vpMTzE9Ojma39XU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p3GLHkVb4kULu2rXXBceJbSAt31IRVagXULG9AxKJ3ExYLWip8EoVNKV478KwAgkzVXYgTEXxlxSz7pHqR35CqujDeB8gZZrH2637HFUiLAcYq91izAgm6ofN4ko4nDFzqlMdXw+kLkfEbgqjZW3gdw2EJsRlK1Yo6dOqYVHO9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5c6559620e3so1450745e0c.1
        for <linux-mmc@vger.kernel.org>; Mon, 07 Sep 2026 05:19:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788783589; x=1789388389;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Tty7R6qNyM6xJP4pDUeVUDGDAPfBrPAZij5mJHmykyU=;
        b=LWUnZHfUVBPrYQP7Arhh3Ky0qPTD6TlAvqNf38qt/P5GBSvmzCJDsA6HkJriG1OeS+
         iC2yqek04Hv8mRcxH79KH6AwozPOvrBzDNXv7GFxrdpF6QcnEk9u3TwRAP3CFfanwIdc
         X1ecXuKBBLo7oEKw4SD3zhuo5wg6H/JpcYoR7jvCnyvyk9+Le4KW9uxrSzV5nLxWylsB
         ICPELfIEB+JQfZXzEg882frxe2qdXClgyT0gSkogB2GFoX3qwp7uE5s+OoulSTSYWoNA
         hLjf5L4C7sYJSdRVjRXpi3H1mNeSS9s6eu0EtPZze//PAK+Svweb6gTQr4E7rXqMt3dd
         ArlA==
X-Forwarded-Encrypted: i=1; AKwUvBxc8bAMu50OhGCCiUN+dWR4K+PYwZ3qGOJqt0kd/TaU82jFVBRs2GyUXxQcrRNZrJFYvTnf1b/Nl7Q=@vger.kernel.org
X-Gm-Message-State: AFuF++kC5552lcNQubzbBa+xdrfRg2Uimj0IF8Ox8gfa3b1hE9AFblcY
	cmHD24S9AoF7xOaZLW0Ln74uP4oJcMvJoJ72MP6vzThH9pCz+PQXSCS3/HmpkA0C
X-Gm-Gg: AYBFou1M+3C0kZg7l8DALURqYc55vwe9KAa6kS0Fn8Grqz21hKMXcaiCE98S0RuPum/
	sPoMrxB4aFgDrOuQJHKOEzNzv6Otaj1+gJWUFVlkdIyaOa2JJpZ3cAsnUaHTr8Ltv3dyu8rGFvz
	EIUeatZAI+r1sm2BcpgWk7jX/YP8jHiPy6Il50J46l1jelW8v+Mcc4t5Wo4p7bEKySwrasXcuZq
	ioB5sZBA75BQkjNBEy9JpVRm+e5NiyvMz2xgL6iBzYlbbY08LIwnbrW4Lto+Fp3VTzQsvhH0WEj
	KnW552akjWVcQTHTzW3S/83JEbrxkPxXj7bN1eTGl7jHREjVAF7vHNNgTVoxDdVMRg1Z19MUPA0
	sBd58qwhT9o9WmNZ8BgFsYKzAF+JNfYafxI/HXcTC8hvVWLeAtYBIq/+Z+BObTD53KkdqVtnHjV
	XqqFenNuCRoeOhj7eOs7XDALunMelPbPfWIuBHwiATwxANQq6vvgoEtoJx1jDERvRx81QmKX/9n
	ibt3+SITeaY3Z+90VSN9VSk0g==
X-Received: by 2002:a05:6122:4f83:b0:5a1:fbbd:6bd0 with SMTP id 71dfb90a1353d-5c7ed45ea59mr9142847e0c.5.1788783588613;
        Mon, 07 Sep 2026 05:19:48 -0700 (PDT)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c7ec24254fsm7488051e0c.10.2026.09.07.05.19.47
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2026 05:19:47 -0700 (PDT)
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-9667ea2fc22so762444241.2
        for <linux-mmc@vger.kernel.org>; Mon, 07 Sep 2026 05:19:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwciCCrwyixGV5hNAtXh1ZB594JL86dL7Sa6jgWsiar6LJV6VeFprI0nzDiVRW4ky5lshRaB4GY0Nc=@vger.kernel.org
X-Received: by 2002:a05:6102:e0c:b0:778:721:53db with SMTP id
 ada2fe7eead31-78a4a4ca11amr6528611137.0.1788783587284; Mon, 07 Sep 2026
 05:19:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260816153809.7067-1-jakovnovak30@gmail.com> <aoLCr8JEYaYxcJcQ@hovoldconsulting.com>
 <61c4cee5-3c63-4b09-abbf-bf945b538403@I-love.SAKURA.ne.jp> <DL91IWM6YXRN.3892K60CVKZ3U@gmail.com>
In-Reply-To: <DL91IWM6YXRN.3892K60CVKZ3U@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 7 Sep 2026 14:19:36 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW99QjUrat+K_Ot025Zddb5p-rBhpPxP8EAE6FmfvEnWQ@mail.gmail.com>
X-Gm-Features: AcwNN1X_Y6VTAkiTUVaCeny5TBDUQ3QnkakivGhNq66Ha3LNCkcjAS164CJi4jY
Message-ID: <CAMuHMdW99QjUrat+K_Ot025Zddb5p-rBhpPxP8EAE6FmfvEnWQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: vub300: fix sleeping function call from invalid
 context in vub300_inactivity_timer_expired
To: Jakov Novak <jakovnovak30@gmail.com>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Johan Hovold <johan@kernel.org>, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kernel-mentees@lists.linux.dev, Ulf Hansson <ulfh@kernel.org>, 
	Guangshuo Li <lgs201920130244@gmail.com>, Runyu Xiao <runyu.xiao@seu.edu.cn>, 
	Shuah Khan <skhan@linuxfoundation.org>, 
	syzbot+1ee4f3b9228e35f14677@syzkaller.appspotmail.com, 
	Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"

Hi Jakov,

On Mon, 7 Sept 2026 at 13:18, Jakov Novak <jakovnovak30@gmail.com> wrote:
> > syzbot has an AI-generated patch at
> > https://lkml.kernel.org/r/49982079-95f4-4e8c-bbbc-bcb127e2f378@mail.kernel.org .
> >
> > Please check.
> I checked the AI-generated patch and it just uses the deadworkqueue in a
> new function. That is the same thing I am doing except that I'm using
> the vub300_queue_dead_work function instead of writing some new code
> that does the same thing.
>
> The real question is whether mmc_free_host should be allowed to invoke
> the sleep function or not. Geert needs to elaborate on that since he
> added this change in 1036f69e2513 ("mmc: core: Cancel
> delayed work before releasing host").

Why would this not be allowed?
This is just in the driver remove or probe error path.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB05021254B
	for <linux-mmc@vger.kernel.org>; Mon,  7 Sep 2026 12:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788783482; cv=none; b=u6epN2SdORGx3N4zwulYoSYJHbI66j54MJfLfWjZddIUtVVhvnN4y3bwdi2BdkA8ie5fqh1SWYtpJz1i8PioKQAFOB3ZvxlAvzIEGeJ4JSziHBHiQLoHmVUmVc98CWUQ4QOANJeOQyKDlcssavZD76sBCDIGCWaPmkhr+9aEABg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788783482; c=relaxed/simple;
	bh=VEx282xJoSaEd9yFgg0bC7E3UZwOapIeeglnsmObeHE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MT//iz3oBbTX0AGqn3Uz3nedT+nAgj8HLpxg0GIREZChauqj5MfiWYqKMf4Cty2bs5iT6GUs762I4VzKu8d+jiYx9WjqZYcVC/3pDc28FgDBHQGrtuJ/sJLDBpXTWPFR7fYhTFA9W/t6s0Kfqg9Qa38rn8xI/TIQcYME9IqZjow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-97fcda3952aso873429241.0
        for <linux-mmc@vger.kernel.org>; Mon, 07 Sep 2026 05:18:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788783480; x=1789388280;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ICs1H2dY7Gpq4y5UR8p+p9hgLN+TaINBuRZGUQCEu4w=;
        b=PSGboUnoHmLxHihD6eNkuF55RQBsTEFrPM6+MLgZKFifLN03aFtdQ9IrKRTgKalR0h
         zBcP6aA9NDLGtJd06dlkbhVnMpTp1MyAeXb02kQgawfJ3fHo5xR8+jeqYvLrgq1kVaqk
         BcDiibhSCVXn5RcvSUTe2JeW75KwjOzgoBEIYsAgfEWsku1+BQI7CUxEdREu6cslvyXP
         VbbXgQhqsEEhDmPGHa0L2SiVGZIii0BRkFGRuCgpMqDzTWcT1sjpBF/XuSw7WdKO1ATs
         fwU8olVPgjLiyTIeHiUFL7iz7BtPCUm9o3ZjMwM70jQhoYsxnsbGh6ArM1a4U628MjT3
         UwvA==
X-Forwarded-Encrypted: i=1; AKwUvByqZ5meSJ3tx6DLzXtc3nuGhePOkvV1Tv3mRepyKhfhdZ1EOhi+evGNaTrr7/Hpet4F5IwBoLJTQI0=@vger.kernel.org
X-Gm-Message-State: AFuF++mF7Ug9cj9kljTnSip+eLRJhS/eF2TP0s5Qo3S3D09dLxVB8dwa
	93cwPa9+Ne0xlc5q1AIsiTMvNNqe8US0Rt+YlTT9P/Sa6R1tioKLUa1hj0WvlovC
X-Gm-Gg: AYBFou3nKFbj3SPT07Uw4f7t0kUcIf+a933J5qhDWydtCsdO0pNBSdvAQvmJeHtee1g
	C1LCVdnk8YFLzMVFgTFMAygs1uTvw1RZOVeCmI1WMGQuTB5JCHYz4QlB+KF6NEnfhpel0a1LNTR
	SZsrH3nJhVqmQswuIKM0VTJBYkZg0JzLfznEraOkCrlsNusHqRqJ1I9ADelSK5lmG2f8fXNgH7U
	D5HchneKl26RBE+vgw6I6jtmiI6BNrwTIR8HWzg3vaBsK+IA/DEweO+9Fhe3RYJVlkdRndGnenh
	4o1nKPyhb7MbKfBpeXq9Hl5bFQXQkq3171MXonR7YgAuQXQ5vceSN3tKCV6GDZ8fxAA8o7J/xXl
	1daBoDgdfiEesx7q8yqdE/I4v0l0qxYd/YCs6JrLZCi6fLSvMnpJydGxmXGYTgImNzFUUY59KrT
	CS4G1vssc/zFIG7i6rhnJAaKrkTu1TVh7K7OB3LcRZgSYJoF+Fh0r87LmxOrmrExYDQtqsIc/+G
	xWXg7s78zDq+n5/Kk+fe0OgzH0l1WUAgQa3
X-Received: by 2002:a05:6102:3a0e:b0:786:c223:ad84 with SMTP id ada2fe7eead31-78a4a9c39cfmr8878434137.9.1788783479699;
        Mon, 07 Sep 2026 05:17:59 -0700 (PDT)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-78a47b3468csm7016724137.11.2026.09.07.05.17.58
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2026 05:17:58 -0700 (PDT)
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-97c7afa485bso1987106241.3
        for <linux-mmc@vger.kernel.org>; Mon, 07 Sep 2026 05:17:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByVusiDxv8UX1GgilccQT/1lNyfcn1lKZ1pJlXki5GWMd7a7QkXaZ5Udth1stacYqUGNqb+CjjAPKA=@vger.kernel.org
X-Received: by 2002:a05:6102:5126:b0:785:5a17:739b with SMTP id
 ada2fe7eead31-78a4a4944femr9543602137.0.1788783478176; Mon, 07 Sep 2026
 05:17:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260816153809.7067-1-jakovnovak30@gmail.com> <aoLCr8JEYaYxcJcQ@hovoldconsulting.com>
In-Reply-To: <aoLCr8JEYaYxcJcQ@hovoldconsulting.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 7 Sep 2026 14:17:45 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU_Rx4ZGi9SsNxKUDyYmV-GbD8rD9NMVzYginBMXdZDMg@mail.gmail.com>
X-Gm-Features: AcwNN1UGIwaDEpSQZPDqi3a020L7heHOErQjuz6sflvRFDaDCrMR20u-OR5PZhk
Message-ID: <CAMuHMdU_Rx4ZGi9SsNxKUDyYmV-GbD8rD9NMVzYginBMXdZDMg@mail.gmail.com>
Subject: Re: [PATCH] mmc: vub300: fix sleeping function call from invalid
 context in vub300_inactivity_timer_expired
To: Johan Hovold <johan@kernel.org>
Cc: Jakov Novak <jakovnovak30@gmail.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev, 
	Ulf Hansson <ulfh@kernel.org>, Guangshuo Li <lgs201920130244@gmail.com>, 
	Runyu Xiao <runyu.xiao@seu.edu.cn>, Shuah Khan <skhan@linuxfoundation.org>, 
	syzbot+1ee4f3b9228e35f14677@syzkaller.appspotmail.com, 
	Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"

Hi Johan,

On Mon, 17 Aug 2026 at 10:13, Johan Hovold <johan@kernel.org> wrote:
> On Sun, Aug 16, 2026 at 05:38:09PM +0200, Jakov Novak wrote:
> >  Currently, the function vub300_inactivity_timer_expired, which gets
> >  called in a softirq context, calls a sleeping function in the following
> >  call chain:
> >
> >  vub300_inactivity_timer_expired -> kref_put -> vub300_delete ->
> >  mmc_free_host -> cancel_delayed_work_sync -> __cancel_work_sync ->
> >  might_sleep -> BUG
> >
> >  Fix this by replacing kref_put(&vub300->kref, vub300_delete) with
> >  vub300_queue_dead_work(vub300), which does the same thing, but in a
> >  workqueue context.
> >
> > Fixes: 88095e7b473a ("mmc: Add new VUB300 USB-to-SD/SDIO/MMC driver")
>
> This isn't the commit that introduced the issue. The blocking call in
> mmc_free_host() was added by commit 1036f69e2513 ("mmc: core: Cancel
> delayed work before releasing host") in 2023.
>
> I didn't look at this in any detail, but having that call in
> mmc_free_host() (e.g. rather than in mmc_remove_host()) looks wrong so
> perhaps the fix really lies in MMC core.

mmc_remove_host() can only be called after a sucessful probe, while
commit 1036f69e2513 fixed an issue where the last probe step failed
with -EPROBE_DEFER.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

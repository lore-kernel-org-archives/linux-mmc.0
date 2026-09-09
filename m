Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD18C393DF9
	for <linux-mmc@vger.kernel.org>; Wed,  9 Sep 2026 09:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788945459; cv=pass; b=dqNTqdVshEpXe+4XMHDlQVlzwPYLd55q/doRId7mvRRJ4sevLm+kPJubrHOBfdsKzYwm2SwFdg3zzcK3YtDiSorNYIXrBCs7sinOYVimtH86YixMIpQGd3+1d+V7eOHpbeJjRYil0o5SEPF8HzLKk+VrZ5Ke/QEwmWss3vcRaxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788945459; c=relaxed/simple;
	bh=/F5y0LLbo/rROmeDIaBjtkQ14p/OdkwBq6ce/vqcU1Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NPSeyDf2k8FIx3GG73fTPxxw1cxCQRf6Fwk0kKpiX99Sixq9kKD2CjfRScJ6jkxoaK0AVljUzSNdCsfwIUqzfFJxUtZB26gx97ToZp/CGJM8cV4tLCq1JGnk+JxG9/yaLsUm94fISyBrbBYHFz10ny27h2KHZnXEg8qf7h/iyPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P4+cWc05; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4+cWc05"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-66c744a00edso4782897d50.2
        for <linux-mmc@vger.kernel.org>; Wed, 09 Sep 2026 02:17:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788945457; cv=none;
        d=google.com; s=arc-20260327;
        b=rmisj6q39CoaNPcFb0r7trf3FohIYb9vpHDoLOWlATuir419Wi5VyAyynnjXF6zCsi
         +SUF2mhkNsWhCWFKlAJQ2dUu6YPWBsnv9YcVMSnpFSpdiPWIghrYr1moaLMBXEmMVAp6
         iXmbo7FhCh2uXvYIbX9FuWos2t4NgrAHckYcYfe2nk0h11dXrJDLHNG8Hs65a1RLG6Rx
         9x0T/pqC96VF0KllIGkDbE83im7Lkad4LUSK9D/5m0R2+EnRK0o45yTMaVWGMA5umf6+
         iVOlQs8GSfIB+JijMH1aIEzAZy89rILMpIL779YGB8wr2kPtAZ9Q8v9nD/hCKzYU0PhU
         Dl5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=r9wGTvuYE4vQRVTrjaHercWI+jZS31FFyBXWpLNHH7g=;
        fh=zN6ed8QIstH7XZTvzv5Z2MSCEHr9PlpYH4UpuSbgrV0=;
        b=OvuK/Kdir8f2cs2rqLQ7GYuTJ9wwOfAxbTT0ST9O7Y1+f2EJEvAeJymeWaZGA1G6Z3
         MeP7Iakn7SWxZtuqtSh3gpVvzRCVUQ6JijOZ4aOGlPE57bDQDssJ7XAj1lssIyGXeM0X
         PjY1QQP1andVY5aaZocfIlAMpbfKNz97PyFner6elZGSLGd0fL8Mv2pMJ5VH5oj7ylJw
         TuYnGUgCcxwWIVRQZ8f0DUZi25nKnE+SHmhwy1WY5BnwAAmPTkum5k6m4+LziuZBzkAk
         S+7ZvWfMRDcFFyDQfyakh6Xq8Oh+zRS8se0Se4paXzVrGXTGLnlSPoM3PjdmDZzKmPTV
         exag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788945457; x=1789550257; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=r9wGTvuYE4vQRVTrjaHercWI+jZS31FFyBXWpLNHH7g=;
        b=P4+cWc05pTT4q15oFlI1UFZXqnTxN+Ss/kXUvM+iNhkeeA5xuchJs/RztcQMdEWgvG
         nfM+/CXE0o324kWWG9+YGvff+3tj0kVHVdOtmamvckF0wNj4TA6gAlwAVBiFN0NZ0Iqx
         y4hKod9frUoaFrpy5spqtdLBiwnf2eaANwCFMe/jQHihTb4tQqKokogJMJg9IL2CC8yv
         iNJm+RMbGi8+dKj22mWjHSmGanCR4ce5WzSEvhW0NsBG2fxLs4UCWwBJiF39z+LB73x3
         h72mX2XjSBWYHZHgPUXQcumeMUvVLNG6gUkNgYCS/40ifIIpFLkhEhO5kTKIZsI36tWh
         +fSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788945457; x=1789550257;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r9wGTvuYE4vQRVTrjaHercWI+jZS31FFyBXWpLNHH7g=;
        b=QcLI/7/xit9kusBJUPd/0p6fAUbv5F9WDc53BI7yRQsM2RfMGNrcW35fLNgd79jzoh
         PfQnRYFS7jh6tu4W5jCFkS8v1gartgtdUcg7S1jNlY9i1N4SuzcwIoVFlsZI2w4a8ox0
         A7ZR/aFJKdaLUi3b2AXjdP8DLcqJxBIxTLC6NAbsNogBNqMnbbVTlK8HOkBUb7fcYph/
         rzdVyedfXKcct/WrvndX3JrpaEwcuWTn9MDouRAMvQv2DNld79e6wpCsvk4ILr39J467
         JLKtG+7AtxvVgi1/HAf1SXttdZlNAu5peVQkTcDkl2hWwJUNFi8hT7GHBtYay5f1+Sfu
         Jcvg==
X-Forwarded-Encrypted: i=1; AKwUvBy0DzcxiH9KJ+/Ri2OfDrvlqIYql+dtaNPGkoKlTQSvc4HsQkGhRnSdDcMK3K5J1/0QSaHx8UU/Nck=@vger.kernel.org
X-Gm-Message-State: AFuF++m+A/xW2s58w4fgS3Z0xjqZD+q6+KXO5OaoxkRGqBhOzg/GPCeY
	J9V8E5q5HcslAUAt1Yom1g+raQXAtSvLwfy6unlsMhpMC0J3bOd0Nwjz/Y0Kcr1k1+ZXehEAXCx
	lXIEWLQqgG75yHCd+QmcTygKwuPSoyC8=
X-Gm-Gg: AYBFou3iyoCy7A7uXYmUTp0mFuOmj2Fj6/y3zKwyo8xDrEj3dWRn+eLfOE09wsT+HkX
	rfdGb7Ai/KyWWcf+lUedeQK5BH6TT/cRztKvVYlYWURkoFPYJ7fY8glXZGDRyr07WpQceghRgcX
	SnOrcs0oEF3oZT0LFVJCgdAWJM+F56M9zphQV35IRGiAd/GTDuwNzj2jPlyJ9JKvuhUpffAM+1T
	5E4MYF/PsXaLbZb2q5K6XC917Y/YN3QMqbSGzT+ctiTOXEMgcUp8dc786S3VmwRVzEQNYM7lfQ9
	etJzL/SVu51rcdPWpLQxT993hKEU/JAxFqoZFNWu4OXFSo+KwT1TzpE=
X-Received: by 2002:a05:690e:1c1c:b0:669:586a:8673 with SMTP id
 956f58d0204a3-66fb59c3a99mr9579045d50.21.1788945451966; Wed, 09 Sep 2026
 02:17:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908165050.1930-1-yogeshgaur.83@gmail.com> <aqECZPhDe_elcG5P@hovoldconsulting.com>
In-Reply-To: <aqECZPhDe_elcG5P@hovoldconsulting.com>
From: Yogesh Gaur <yogeshgaur.83@gmail.com>
Date: Wed, 9 Sep 2026 14:47:19 +0530
X-Gm-Features: AcwNN1UrL_UevZsQ87HP2uUJ-wroDAR-zlHUb94yZCqKoThFwwjaLsdUn3pBCg4
Message-ID: <CAG6enPw3DPtHR+VX=nE=oTUC08=feH7rgPnxkFu2s1k=CbCjcA@mail.gmail.com>
Subject: Re: [PATCH] mmc: vub300: never tear the host down from the inactivity timer
To: Johan Hovold <johan@kernel.org>
Cc: Ulf Hansson <ulfh@kernel.org>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Runyu Xiao <runyu.xiao@seu.edu.cn>, 
	Guangshuo Li <lgs201920130244@gmail.com>, Tony Olech <tony.olech@elandigitalsystems.com>, 
	Chris Ball <cjb@laptop.org>, syzbot+f4a0159ce6802a0a4774@syzkaller.appspotmail.com, 
	syzbot+1ee4f3b9228e35f14677@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 12:23=E2=80=AFPM Johan Hovold <johan@kernel.org> wro=
te:
>
> On Tue, Sep 08, 2026 at 10:20:50PM +0530, Yogesh Gaur wrote:
> > vub300_probe() takes a second kref reference on behalf of the inactivit=
y
> > timer and arms it:
> >
> >       kref_init(&vub300->kref);
> >       ...
> >       kref_get(&vub300->kref);
> >       timer_setup(&vub300->inactivity_timer,
> >                   vub300_inactivity_timer_expired, 0);
> >       vub300->inactivity_timer.expires =3D jiffies + HZ;
> >       add_timer(&vub300->inactivity_timer);
> >
> > and expects the timer to release that reference from its own expiry
> > function, once it observes that vub300->interface has been cleared:
> >
> >       if (!vub300->interface) {
> >               kref_put(&vub300->kref, vub300_delete);
> >       } else if (vub300->cmd) {
> >
> > That is wrong in both directions, because the expiry function runs in
> > softirq context.
> >
> > If the timer happens to hold the last reference, the kref_put() runs
> > vub300_delete() -> mmc_free_host() -> cancel_delayed_work_sync(), which
> > sleeps. The ->probe() error path arranges exactly that: it clears
> > ->interface and drops only its own reference, leaving the timer armed
> > and owning the last one.
> >
> >       BUG: sleeping function called from invalid context at kernel/work=
queue.c:4487
> >       in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 191, name:=
 kworker/0:2
> >       Call Trace:
> >        <IRQ>
> >        __might_resched.cold+0x1ec/0x232 kernel/sched/core.c:9197
> >        __cancel_work_sync kernel/workqueue.c:4487 [inline]
> >        cancel_delayed_work_sync+0xb8/0xf0 kernel/workqueue.c:4568
> >        mmc_free_host+0x19/0x30 drivers/mmc/core/host.c:700
> >        vub300_delete drivers/mmc/host/vub300.c:379 [inline]
> >        kref_put include/linux/kref.h:65 [inline]
> >        vub300_inactivity_timer_expired drivers/mmc/host/vub300.c:747
> >        call_timer_fn+0x11f/0x610 kernel/time/timer.c:1745
> >        </IRQ>
>
> > Fixes: 88095e7b473a ("mmc: Add new VUB300 USB-to-SD/SDIO/MMC driver")
> > Reported-by: syzbot+f4a0159ce6802a0a4774@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3Df4a0159ce6802a0a4774
> > Reported-by: syzbot+1ee4f3b9228e35f14677@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3D1ee4f3b9228e35f14677
> > Signed-off-by: Yogesh Gaur <yogeshgaur.83@gmail.com>
>
> You forgot to add an Assisted-by tag.
>
> Several people have already proposed (LLM generated) fixes for this.
> Please search the lists.
>
Thanks.

v2 adds the Assisted-by tag.

On the lists: the closest prior posting is syzbot's own AI RFC [1],
which fixes the sleeping report by deferring vub300_delete() to the
dead work queue.
v2 cites it and takes diff approach, because that one leaves the timer
inside the reference counting and so does not close the second report
(f4a0159c) - the mod_timer() calls in the command and
dead work threads can still rearm the timer. Shutting the timer down
closes both.

[1] https://lore.kernel.org/all/49982079-95f4-4e8c-bbbc-bcb127e2f378@mail.k=
ernel.org

Yogesh

>
> Johan

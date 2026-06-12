Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC9D2F7EF3
	for <linux-mmc@vger.kernel.org>; Fri, 12 Jun 2026 03:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781236488; cv=pass; b=PORIZGFh0QBtWa92l5oOFpqZnFx9xyb9A872pv+AfeDLOf+BjYxoiufifp9pUlz3fcRS7zHpvgk4WbxA0EHr3qAIF51AZHTlthC7HDAifE3K9DLx5X0UKrK4nBDf8AVNonQwEQwCkyvvODQh3sZbq5E/1D7ND+s+e3uhQWAyoYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781236488; c=relaxed/simple;
	bh=zUAwt9FZfmQPtqgK1je18I0ZfZIQIbADelZ3sHfNYOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jn5AFGfvf8v8ecZNR63qaW8VM1aNxPkE3SC9A+KfJEBIHRn2UduqHhKVsGUelVTPSpTU82t5v53EmwTJzFNJD6RzXyFe7a/q+WfNLeXrJe69wOyPaE72VUhE6WHUYhNgVnLHg5sTejNKrusPXTrihdYIE2Az69rFOG12xrQ2ZRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JflS++sk; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JflS++sk"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-6603246b66dso573028d50.1
        for <linux-mmc@vger.kernel.org>; Thu, 11 Jun 2026 20:54:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781236486; cv=none;
        d=google.com; s=arc-20240605;
        b=XAL2aBYMjoqUyULENEMnP9247/dD/OipyHzvTKcf9CEE9qSaF4W/l/jc9TnpR45/5b
         tj0fnX66kIbgwSAckCos7e7n91W3wd7ekf6s64QlS1i0aH29SbX9QZlZMASI1mA8Woi9
         D7RRsAgv9LK24ZlTQGvClczt+im2/9Qjh9J09MJVNLyhGXVvlRJrN1sQxgpDEwwMTpHy
         Ak0tf8V8QbRVqUX+9Ot7B/9CCUnO4I6ssdUQ1TePdFAFXxA79iMYEIuJfWTL7zhV7N7E
         qd9skuIkqDFFrN2aPq8AcHwuMve8e3LyK/wE4uz6jfYpDCce71ERl0JQEv37h7QIZyaG
         CrJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=L7yB6g93c1lnYPkEbdFCPz3/HaqxtLSgHPO8Ug1YADg=;
        fh=HGecicjGmZ9VVCK9UP1IDg4qUaRcnIU1des5O1xKi5k=;
        b=I05Mwy2/U+LjB7UfRBdwrjOsqFuaadbkiLyEiEe+dTNInpD5b3gss6zW/IgGZMRuu4
         vELump8okfoiQOfEe3MG3IxkUhdqUosUgIHlX3iHpmBqu0iIEVVpZCTt0bbEewVHbPT6
         MdBn8RFS7/1oe1nyYeUw9Rej5jIxFRGYAnywcRmT4d9VQk8TeOtcNatTNKXW+uaYPI1f
         Qc9fX0pRFv93BxDEfGMIlTJwXLTA7pr795STO5OUcbscje2ogTQr1iEQ42otNpy0hxYt
         1OKUMAeg6A942nATyTUJApp/pRzRL0c7Nhpgq6v6IPE7kVfADWCJO9uDNta1F7Um+GpY
         jnHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781236486; x=1781841286; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=L7yB6g93c1lnYPkEbdFCPz3/HaqxtLSgHPO8Ug1YADg=;
        b=JflS++skjmRH5XPknQ71YoXWt4xOQzGT/uXYPJ7J0EqAKvXibcpiHn7mr2RYmv4SNk
         e1UTSkJPsUqS+I14Lszq6R7xodbG37UnRehFcuoOktHVBwypPCGgSQ4s+04aG7HNag7O
         DnIGzbzYTH/1XX3IxAqx8wwtOs3LrF/jqLEdM0Zp2Nqgx8XQMs3sCzbdqdyqXuR3//Mo
         xLcdFn5/HSW/Qm75aN/inlutTWUQ1LMHcJfa9IEjBvTWCXoYLp9axmnaodbCQfGjpyPh
         JPY4x4FuPu39k31OAxDJDWLeA0wbJoZBdAnarRxFylZ9zRpU/09VTUSxJ3S+DQyDWIS2
         tsTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781236486; x=1781841286;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L7yB6g93c1lnYPkEbdFCPz3/HaqxtLSgHPO8Ug1YADg=;
        b=BYapuQVDbyhWEk5vC48X7z/0KH3rtH+g77jU6eCaEGo9MS4x9uPL2H++AHO825XmZ7
         PTbOaOn3pupG7a/u6XVwmt3But1RrDvevkiCyVHQ8XKW5WMxC9Rn3Ugv6FdnAz61eIas
         1HXTX0S/KEpWIryRznpaN6ENOo6ypM226PBN1FaBkX4Zz+IHvqbPDuIgygqwIabGqc6F
         UQp27sBmheYUKFaArfWONo8udSeXQ9WGGSgbR0J8M2IzG10BsXa1KSk+LtpuZbVOKxvZ
         7xcU5HXNvgY8Jmz0m0PNwKWiQGXGtMnE8IzJlu58YvkwiY7ITSTHikzQUcHw9l/3PcG+
         0QHQ==
X-Forwarded-Encrypted: i=1; AFNElJ9zRtTDevT/e6lOnHoPLdHL2kksVuu3vj6arjlW08G6nR0jDyA74/aug3T8glC1/OCfF3azLLYv9PU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy28UNS/bjpy21zHRF4lNmVPfkNnvzRUI2tOXBCZIy+es+O8YIs
	7bCPQDCDkzmocBq7IY3VELXyIEV4GaM3v92MnmUtlZZhGqYYg+FY0WacVnm3zO7+ELnRTRvTqmc
	IA6eA6MzMThGN8HPE96BguNKa/VIChBU=
X-Gm-Gg: Acq92OFcLm10yjRuLohD0gFfFKpIbZwnrtHh0iV5hBY61wjchWngXo4Xjlt+9EZ0T3j
	Xi7Hu8g71RJM2A2dEjGKBEJWVVoiF+qxnCjp/BKt2tNQ1sQIKO590X/xomIgMENXjhZbJKA2bdy
	XRFv5CciQPWsYlSKS09cojWmOGWvYiMbfzF+if9jWeGn8ByQ9puJlGKL3UntGSHbeC+OQxy5s7h
	KC0FcGyoPccKZe9NGU3uRIvc4R6U3+xdLIYCJWRtPC1f++vFjjsg0ZCTrj6uTQ4azAHj6QLYZDp
	CJtEKtsf
X-Received: by 2002:a05:690e:138c:b0:660:6bd2:499c with SMTP id
 956f58d0204a3-66278315e6bmr819125d50.32.1781236485995; Thu, 11 Jun 2026
 20:54:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610145630.1788731-1-lgs201920130244@gmail.com> <ail8K3v_Ho06rNCv@hovoldconsulting.com>
In-Reply-To: <ail8K3v_Ho06rNCv@hovoldconsulting.com>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Fri, 12 Jun 2026 11:54:28 +0800
X-Gm-Features: AVVi8CdYQAXhGMa5S-2tmtT08YZwVs4v4z95nCBp2zI1iLDM0sH_P1Q9aExBA80
Message-ID: <CANUHTR_N7i=Jz+uay-Fs3x+UQTfbWFgNBFHu7v9CPO5UdkKuhA@mail.gmail.com>
Subject: Re: [PATCH v4] mmc: vub300: fix use-after-free on probe failure
To: Johan Hovold <johan@kernel.org>
Cc: Ulf Hansson <ulfh@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, 
	Binbin Zhou <zhoubinbin@loongson.cn>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 10 Jun 2026 at 23:01, Johan Hovold <johan@kernel.org> wrote:
>
> On Wed, Jun 10, 2026 at 10:56:30PM +0800, Guangshuo Li wrote:
> > The vub300 driver lifetime-manages its controller state using
> > vub300->kref, with vub300_delete() freeing the mmc host when the last
> > reference is dropped. The probe error path after the inactivity timer has
> > been armed still bypasses that lifetime rule, however, and falls through
> > to mmc_free_host() directly if mmc_add_host() fails.
> >
> > The race window is between arming the inactivity timer and reaching the
> > probe error unwind after mmc_add_host() fails:
> >
> >         probe thread                     timer/workqueue
> >         ------------                     ---------------
> >         kref_init(&vub300->kref)         ref = 1
> >         kref_get(&vub300->kref)          ref = 2, timer ref
> >         add_timer(inactivity_timer)      fires after one second
> >         |
> >         |   race window
> >         |<---------------------------------------------------->
> >         |
> >         mmc_add_host(mmc)
> >                                          inactivity timer fires
> >                                          vub300_queue_dead_work()
> >                                            kref_get()          ref = 3
> >                                            queue_work(deadwork)
> >         mmc_add_host() fails
> >         timer_delete_sync()
> >         mmc_free_host(mmc)
> >           frees vub300
> >                                          deadwork runs
> >                                            use-after-free
> >
> > The inactivity timeout is one second, so this would require
> > mmc_add_host() to both fail and take more than one second to do so. This
> > is unlikely to happen in practice, but the error path is still wrong.
> >
> > timer_delete_sync() only waits for the timer callback itself. It does
> > not flush deadwork that the callback may already have queued. As a
> > result, queued deadwork can still hold a kref while the probe error path
> > directly frees the backing mmc host, including the vub300 storage.
> >
> > Fix this by using the same lifetime mechanism as disconnect. Clear
> > vub300->interface so that the timer callback and any queued deadwork
> > return early and drop their references, then drop the initial probe
> > reference and return without falling through to err_free_host.
> >
> > Fixes: 8f4d20a71022 ("mmc: vub300: fix use-after-free on disconnect")
>
> Still wrong.
>
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> > ---
> > v4:
> >   - Fix the Fixes tag to point to the commit which added the
> >     mmc_add_host() failure unwind.
> >   - Add Johan's Reviewed-by tag.
>
> And my tag is not there.
>
> How are you generating and reviewing these patches before posting?
>
> Johan

Sorry, Johan. That was my mistake and I did not review the regenerated
patch carefully enough before sending.

I have fixed both issues in v5.

Guangshuo

Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C00314A85
	for <linux-mmc@vger.kernel.org>; Wed, 12 Nov 2025 11:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762948264; cv=none; b=P2/WyJrZClrN89hzPWvN+rLpsCGpTjYiGCxzP8Iflx38Y6IOeTm19qGQjCO/8YDpxnhNWgtB7Y+IjKwGDAlkJAq/ekjAIpgIAu3I1XzEPApE0ozJL19vMQCWzkTgL6EGtELurX4uFQuanNzXMLcHRmYVxeudfNHIIDjNawT5uSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762948264; c=relaxed/simple;
	bh=khSs2jIaNnzovstTr9PNEISsbMkAq+WBzKedqSbiF30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tgPsOFrP27cuo30bSVlOqJxHwIFXZXPrcEEWXqcdQ0BD5Lo4q+gWwzbHtPMwGucsh7k8HmZ980uvRC8eBGLADCCgLWbCq85PHPNSNUfTtI7EHbNP+svBeRqtntJMnitNkjt4KHBQmoXDY6XMT+GhN32/8T27BVZbIr3Bipb1muE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LP45Rqtd; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LP45Rqtd"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-59447ca49afso1182497e87.1
        for <linux-mmc@vger.kernel.org>; Wed, 12 Nov 2025 03:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762948260; x=1763553060; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=khSs2jIaNnzovstTr9PNEISsbMkAq+WBzKedqSbiF30=;
        b=LP45RqtdP9ja/fJcKuSVRF3sBGMhAj+rL07FcD9JBx1eTfcH09INjFvijwMs30wAGF
         YMwODelXHhMjhx3SWGSECmSi8Y1BugrjEtsHApTRfE+5TPzLlcB3T2kdMBEkf7oz+9dw
         BGxo0C8mQjKO8NJ9z4DqofMF5DGj0aGQrx/+f59dCV04UrjkzthpZqFaallh+cjn5XgJ
         YH8nfV14g4D0ronWRMJKwtXBMu0x/CemjvInAvCQyQoJueTjjdtHaNZlRSRa+yf2ae16
         H9hiZ9pcf+oH2aohqGi9+fDSDRxyZ0X8ZpjCrgn3iZBq0dVqpkVk3ImJAgu9yjSMVo33
         snsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762948260; x=1763553060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=khSs2jIaNnzovstTr9PNEISsbMkAq+WBzKedqSbiF30=;
        b=uyhMt5hbP9vOKG8mBX7TUMXaGSeyyuVoKoRmooDxKOeeJaiSXZhf0JQ1FAdo3T6/xH
         KtCezyI85sy8tEd+HFErrgvdk6Pe9jhhMqHO6829/415FiMeMLnVzLmnHu7AcbiekM4m
         dfC87siX9vhG3P2ae9HIxCA2okZ1tI0UavzaQbOGQDpC/yE1rVMzi5M2gOMwdkKaGqW6
         6LE+CjBNYJYj4IPKir7mxF7SWvXqymmZjtn+TYLXUe6aVAlFm3f0q5g8GQSQdOXFqoix
         BeffcWErwennZFCLKxLd4XMSKacU/CuhCjb7bYhSy1QJHYEvrgb6n+/s/l6U8U6YK9wq
         OeHA==
X-Forwarded-Encrypted: i=1; AJvYcCUNNc8X5oDiuojSaOjlnCJpTJtT5xVjBste555zF5SGOUrr8u2QnEIrkH5ZJ9sXTncwFLi5k3OcVr0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNQX2cAZo/ql9oWlBa4AMtPhe0Yme78LlQmAm14ALvnyntXZ5T
	QVfNzfckqNjPh7qPE4aW0BzKEPDLZ9CAxpohNV6WebVnRzQlt/EAIrlHwxU782UA7rO7rfVf+OF
	G2CVQKxkqibcSEJf0x7Kqj978bev/nVXWqF8tPeD9Kg==
X-Gm-Gg: ASbGncsnEu8x1MM1JlUOCHdmN/H4e04hdsGeKjLRLhJIHOLv3b2kAXjwM4noPXLlAlM
	JHSnr+AC+FcIEXe+pBJyEsh874n5TFinP2PVKlLoKVF6jqnb83syfqQLeR0KXnbJN/HSf9AUeUW
	PJYt5+QCj4jNrd9n9zTjUxJxvV6Et+PnzT5terLKclPFJdnzxwcQoaD3idsXUfpI264ETUzb4Gj
	yQeeVjoQxMQwjLu24L/Z37mwNKHYCiF7vq38sq3VI087PKwRDOxuCGFgTZFC84PSXcvzxwDPEIT
	dHCVpeFkDWNxa40kjA==
X-Google-Smtp-Source: AGHT+IEmrTGoE8kIxUupzcL3o/ACNi9/u4VX1vbVB8YO3B3Zg98bKfvXKx5KfyKYdU8TIau8KPlDz+YmTm7r4eO3RnY=
X-Received: by 2002:a05:6512:3b27:b0:592:fff6:b21e with SMTP id
 2adb3069b0e04-59576e09d77mr876640e87.20.1762948260395; Wed, 12 Nov 2025
 03:51:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107141654.226947-1-marco.crivellari@suse.com> <CAPDyKFp9ugYVm4dm6JkHV8z5Tudi6RWbLk2NrkPA26nCbawP5g@mail.gmail.com>
In-Reply-To: <CAPDyKFp9ugYVm4dm6JkHV8z5Tudi6RWbLk2NrkPA26nCbawP5g@mail.gmail.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Wed, 12 Nov 2025 12:50:49 +0100
X-Gm-Features: AWmQ_blucbv9Z1Lf7SgC596nXzZ7zOuGuRbvDnJLSM-Fwvch4tzK2EHthRN71jA
Message-ID: <CAAofZF4TKr7Tdd52DamxTP2qoebGOC3J0FSrABJLG+AoSwaouA@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: add WQ_PERCPU to alloc_workqueue users
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 12:48=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.or=
g> wrote:
> [...]
>
> Applied for next, thanks!

Many thanks!

--=20

Marco Crivellari

L3 Support Engineer, Technology & Product

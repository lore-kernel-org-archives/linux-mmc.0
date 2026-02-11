Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A11218AD4
	for <linux-mmc@vger.kernel.org>; Wed, 11 Feb 2026 18:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770834753; cv=none; b=cNJF7oj6plOQjSCr8uKkcEbGC7JXGPtyTsLIPDFTIB3/KEVYDxjjJ+dvtX4TrlSpZQNnievQpX8fZM5RE4f/qja1aZWNTagAAU3NXKJQjJQU0DTpxLr7RP8Tpn7IOXHw/PWAP6VGJNiRGSlkGchE8UQ7wtXirzZJ+n95aABUD4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770834753; c=relaxed/simple;
	bh=S9Cvv8+FCa9wUqGPG8JUr5HkOKJXipd9EaAIJI8zLZo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sePlJjzSDTGtSJvxfBZeSwFqxtq6FwFvcawVYI5hT4OqzZFm2oE5EpWq20bROIhbA/fguopJmmyzRWzkBNCPns/Zv7932U/aBjKMaDawbeUmOvnHI9v2kkhB/vNSdb7v3WwNteJP1jmvTheORtCzA5AW4KXVeDoTltYb9DXYN4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Ma1FsSts; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Ma1FsSts"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b8869cd7bb1so1017112166b.1
        for <linux-mmc@vger.kernel.org>; Wed, 11 Feb 2026 10:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1770834750; x=1771439550; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pjn9+rJHWAxlnTQQ40O5iFUNOH8PO39DdAIcXTw9/4Y=;
        b=Ma1FsSts8DX1dJplKZUOckPUNBm8DL2cWqm1xGLxtoclwIvQ/Gwvj8MWXMtQwSNjWe
         3eQz99KPQz7VZIUnAaYBT76habOEeF2voc6k30X8wdRUIxPMAgMQMZ4cEr19dJW5JaS5
         8NWjUyGsB+D/HxFK8GjGSHuYMG10iq/wON7t8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770834750; x=1771439550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pjn9+rJHWAxlnTQQ40O5iFUNOH8PO39DdAIcXTw9/4Y=;
        b=HflT6jlKZ5c7Swnd0iYrQOsBY6ctfhHgf5Dxm8UdkkjHGMAOZgskhQfPIMJHjy3UHI
         mc6Py5JtYPSCx48PnHT+fTc5wtqFbexnIFJyX5442PrmzmS0sUzhhR9RQe+3WI6fMXpO
         9XuN+zcOYgzX/1QXk7jWvrALGiiFEOWcMvhJB5U22R5JSrR38wfHtJtgrp0uIKmY44qr
         bAjhTJwo/wqCKalzMdSF/tdw+FR9YYFOWExa706f4EXcS7PY7GrgUWs7kJPWstJD206k
         i5pKodqDWC6KluAhFyyKvT3i5w61sCJ13iWoymUvJanfOnWAhs/NXTUnRj1t6kTC9rUt
         q+Hw==
X-Gm-Message-State: AOJu0YwCfZcmehoFfsb7JEfPb/MRTyLoAETBPokqO6N0iY4YVwBR6wKP
	f8AQhplJjkOQOD/KSVEy4krbeDd/w8lIpKq5dc5WBQc8OjA/9vb3JsGhrmbdY/OGhlZqL/G/ipM
	n4qIkEDQ=
X-Gm-Gg: AZuq6aICsbHQjTVKQ36ah8MnwpfjeBx7hJ+ltAjIaygCcrANwYIW4np4xhRKczyHhK1
	65AllFwciW7qCLfJRNeAjfr/ROC8n49ATtG+wXwi9AcgvhXU0V1COYEQMX9oywb7PDUBz0iVauq
	Gm5hmeBwBea9S9SmDqXc1BpDrREH8pZkEUe687TIBTHNtdJ8enCjnYlMX3TfwViO9M/wO4BhEWc
	yd1h245KCHvGacJs58IPTRjr6QtSA9oKFxsXEpxVCWk/oxTLQiqmb06aPCjUt4v9kfsVNddey7p
	bVsrnW0q9poaWsbwXFCbz94Up0xo1flSCDBK3ML7AuxexiGjjH6eTCD9HgJYx7WK5fIsb5nPnSI
	x20LNiD64TuK3qlNgfzz7UspgyK5RSwLT+eG72T6KybAfYCKUxXv1N+w8e8Cpccr8vhKhJCTfmQ
	/UgofNTaB+GJMDf+HhB3H8DFUyONTTIY8XUFDDARnN/G49vXy/8QmSNxKSkxHPlfWgefCaj4Mr
X-Received: by 2002:a17:907:3ea0:b0:b8e:7e21:1336 with SMTP id a640c23a62f3a-b8f8f6df834mr1209666b.37.1770834749698;
        Wed, 11 Feb 2026 10:32:29 -0800 (PST)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8f6e952aabsm86530366b.9.2026.02.11.10.32.29
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Feb 2026 10:32:29 -0800 (PST)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6594382a264so10211659a12.1
        for <linux-mmc@vger.kernel.org>; Wed, 11 Feb 2026 10:32:29 -0800 (PST)
X-Received: by 2002:a05:6402:2802:b0:655:a20a:a258 with SMTP id
 4fb4d7f45d1cf-65b96d721e5mr141909a12.10.1770834748937; Wed, 11 Feb 2026
 10:32:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260209133441.556464-1-ulf.hansson@linaro.org>
In-Reply-To: <20260209133441.556464-1-ulf.hansson@linaro.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 11 Feb 2026 10:32:12 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgnRQiKqWVrO_uF1btYM2K8r8xL95RGdKU3QLe8B58nrw@mail.gmail.com>
X-Gm-Features: AZwV_QiV_U9EYUqgo7ArP4MwV9SxOGB8CxlgWoNQItfGhkYt59W9piMEk0kFrg0
Message-ID: <CAHk-=wgnRQiKqWVrO_uF1btYM2K8r8xL95RGdKU3QLe8B58nrw@mail.gmail.com>
Subject: Re: [GIT PULL] MMC updates for v7.0
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 9 Feb 2026 at 05:34, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> Note that, this time I have picked up some changes to improve the mux sub=
system
> and those are part of this pull-request, as these changes are required fo=
r mmc.

No.

Those changes are complete garbage and don't even compile. It has
apparently never been in linux-next or been build-tested in any way.

When CONFIG_MULTIPLEXER=3Dm, we build that core.o file

   obj-$(CONFIG_MULTIPLEXER)  +=3D mux-core.o

but in include/linux/mux/consumer.h you have

   #ifdef CONFIG_MULTIPLEXER

which won't be true (because what will be defined is
CONFIG_MULTIPLEXER_MODULE), so then you get a long stream of things
like

  drivers/mux/core.c:312:14: error: redefinition of =E2=80=98mux_control_st=
ates=E2=80=99

because the mux/consumer.h header will have defined the dummy wrapper funct=
ion.

In other words, that commit ad314348ceb4 ("mux: Add helper functions
for getting optional and selected mux-state") is pure unadulterated
untested garbage.

I do not want to see a "fixed" pull request from you. This was
entirely unacceptable, and I will not be pulling anything more from
you this merge window.

Stop sending me untested crap that hasn't been in linux-next and
doesn't even pass the most cursory smell test.

You can try again for 7.1, but only if it has been actually in
linux-next and properly tested.

                     Linus

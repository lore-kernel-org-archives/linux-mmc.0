Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535AB126F08
	for <linux-mmc@vger.kernel.org>; Tue,  5 Mar 2024 16:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709654406; cv=none; b=UqlpdOmStDAkj5wxkCZr9M9DgBGCzaEwtANoyl7yQ761zo1wn7evzD56oSiN3wC7GDDbMEyQyn8GV1CyEmL1hgDcm3fTdxIKlMGp+QOgRMzO3ZE9WQfG7b25gBMtC3A+CktLBN8xZ1ZKjr61FEu46HMI01b0r5ZOCQNqRss1Duo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709654406; c=relaxed/simple;
	bh=pob8WQzJQuPIPWtXAIHjE9qFPJCKRfquBqH15eKfNGc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WS/xkLsN7060hWeI8351gPm99q7fsCgc5btlLBoKCFKsxYPraPBJRROOJQHA3eUXO4PD1HwY0Jb+3+pF++2bvJHZqB0lHcuxw3zu7hkk49tW5Zff9trb+kHYmxEERMLbE3++IO0CB9hbFA7GYWIRidy++26fVj3GmyCZe26WoKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dn/XjeE2; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dn/XjeE2"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-565b434f90aso8431788a12.3
        for <linux-mmc@vger.kernel.org>; Tue, 05 Mar 2024 08:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709654403; x=1710259203; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pob8WQzJQuPIPWtXAIHjE9qFPJCKRfquBqH15eKfNGc=;
        b=Dn/XjeE2c2teCPmo0fy99AjtX6LF2YyukcEmenxlONEfGPkaZQehZ5Y5DN2Z2si/EY
         p+73oJ+4mq6Ulh94nOokhcxyM+Vdqwj15WkjL7NHfo8BKv2O1sUsvIvlwLfH84aS/xNo
         B7zRL2cfvfJAaPLESmX4e2XsRvFrAvXkBkdS/kXcgICYNYKCFlCd9H955EMuK2W4gX84
         0KvxFgYShe7tzAoj0vRdfHlL+xY3Q88Oh3VNRojlLotnUNtO9CYFDbWV+ZACfr+5s5n/
         t13uuMSfpke75o/99K62qiunMaqP0QzhRPdIYqjLgEgxuygx9xtkP9eEIYtFDEttuBgF
         +h5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709654403; x=1710259203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pob8WQzJQuPIPWtXAIHjE9qFPJCKRfquBqH15eKfNGc=;
        b=hv1FNNZA2f7LyHlNOna8gWQ6/oEqeKKQzMNuGSmIbwVHxmcWWVqwv1+PDghK7QITEd
         adGs3SOFqJfI9xnmbW/QEzZjwEiHGoc1QMiwREe6xoQLNSu/hzDZK0+fcuPVEsxR3eSn
         hfPcyiHycwyvlYhGjB1FBjCu1rmjzUdMq33ju+VN0FniuXtBiPb+0CFIpLEBnZyoaKXy
         3v9v3prll54MhIAQmJrRjoLNKv0DICUBY3RJ0pRI9iB0/YfGxtDJDyIBz9552fuNAI33
         4laifc/GOEzE0TqIT8z3O91akEme6HEUHA6MWlaUaYmm2jk6WROxM3Kle8Aa3Mjy/uFM
         tqwQ==
X-Gm-Message-State: AOJu0YySzNtk3daVrGIlm+0ZnXivFWfUrCHTKCKlO35oGlioXAzfblJe
	hHdRJx+0Cc2dbO4sfx0lpczdwPM9zkXKzjEoTCzd7GknOip09y14mMHoq6fKNA7uDtzzFcLniap
	TPT8HCKMosYuiBECEpFOfZDweaOibph041r0=
X-Google-Smtp-Source: AGHT+IHslyinqegzX1gpri5k9/6cJYbKVbHpoElHP3I/FRqPAUIJ1OMj2uA6IrNJaB6L6c1SN7984S3T/FJtWKamt+o=
X-Received: by 2002:a17:906:fcca:b0:a45:a809:4fb9 with SMTP id
 qx10-20020a170906fcca00b00a45a8094fb9mr1449925ejb.61.1709654403262; Tue, 05
 Mar 2024 08:00:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+DkFDZbYvL9ecEtbpkj=HLMuPC=5QuQHgM8fi_WH2Qu-taDOg@mail.gmail.com>
 <1b300835-fa8b-4b5d-8430-6bfa8e577433@arm.com>
In-Reply-To: <1b300835-fa8b-4b5d-8430-6bfa8e577433@arm.com>
From: Patryk <pbiel7@gmail.com>
Date: Tue, 5 Mar 2024 16:59:51 +0100
Message-ID: <CA+DkFDYMtEW9vp4EmU9ayhb+qCRgqYwKEeAU3LgWiuedSvUt8w@mail.gmail.com>
Subject: Re: Question regarding informing MMC subsystem about upcoming power loss.
To: Christian Loehle <christian.loehle@arm.com>
Cc: linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

wt., 5 mar 2024 o 16:33 Christian Loehle <christian.loehle@arm.com> napisa=
=C5=82(a):
> Immune to what exactly?
> - (User) data loss of data that is still in the cache of the sd card?
> (That would be saved by a timely cache flush)
> - (User) data loss of data that should've been written to flash already?
> - SD cards breaking?
> - Explosions?

Data loss of data that is still in the cache of the sd card

> (Anything but the first IMO should be fixed by procurement and not by the
> kernel, but I'm not sure if that's consensus).
>
> > Assuming that I have the information about upcoming power loss
> > (provided by e.g. external interrupt, PSU voltage monitoring etc) how
> > should I pass this information to the Kernel so that it will try to
> > clean up resources - in particular MMC subsystem?

> There was a discussion, currently there aren't really, but it depends
> on the scenario you're afraid of. Just issuing a cache flush might be fin=
e.
> https://www.phoronix.com/news/Linux-Priority-Based-Shutdown
> https://lore.kernel.org/lkml/2023112403-laxative-lustiness-6a7f@gregkh/T/

Thanks, I didn't know about this, I will check it.

> One of the fundamental questions IMO remains: How much time do we actuall=
y
> have between being notified?

I haven't done any measurements yet, sorry.

Best regards
Patryk

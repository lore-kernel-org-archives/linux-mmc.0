Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E4035F60E
	for <linux-mmc@vger.kernel.org>; Tue, 14 Apr 2026 07:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776150740; cv=pass; b=VzBvyUw/NWg/UA/AIWZVW9DOZKo6p5dvjAe8ME7W9pcJCLETe4aR3LCnNbG/zicuWyRA1kZFDLxeYEU5TtJ6laY/RBjvPSZGIFUutzHmK1KJWI0wZVbdN2vuo9pg6y9xeQIk0onIFaTILjDtYFPM3VFtsioWVk7WStWJbvMOq5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776150740; c=relaxed/simple;
	bh=W21hpU/zPwJ5KfRYuG7wgrTjSpZ+RFTg6vZLOJQgufQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e3m13b4n60pP+m/P4eVmJV7ZzVePdPhmdvr9WCafb7b+YeQi1sRbCrIWdbFo5cd677xxPb0Oqj9SDATS/CnJZH+rCmywnqskggwOkcAAtlqsYHQBnkrKSDSoK0XbNx4sHkayyeJQ8CO61i347Cxjxkks5evKlikwQIPbZHRJYiw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=khQqjzoQ; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="khQqjzoQ"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7991db3dc98so59477217b3.0
        for <linux-mmc@vger.kernel.org>; Tue, 14 Apr 2026 00:12:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776150737; cv=none;
        d=google.com; s=arc-20240605;
        b=Px8DR9A6PfpoUSXtXAFKNMJMq87+HaMnkHCWmrG/HcydPBAT5rE+0QaXG4Gg9NBps/
         BF7qoG5k/RRHnK0nQOSUOwPZRBVRZtoEXCSR8tRKZy/+e1Tj5fAd6LQY1Lt2mMEsCwXu
         Cd7RetULADoueapw63iJXlkFiK0oRy4u3LhN5vy/oq3YfXwuTpzHU29AJkjgEkqICsTQ
         +RGbl55wtjPSzMX+yayJ2fgot1CEoXa6c0aT5e5j7ReOZPzaM2m7sQe9ur7tCgqU1K6r
         9r8zPO+4dsxrFvf5z0l5r1ge+i0Gmlq0E/FVcWzig9FqOLbF+OqUFgIg2TSAHyQ1ZW/g
         3d5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UEklUAX75lJKcC6L2ltl9qbkuGK/MzM9omGGWWVYxIk=;
        fh=qAuy0VXSHMhomSHiJHjyHRXoVPOAhtEd1v2Pa9M7Lmo=;
        b=Y4fKE/7SD4w4cmHJC337td5XHv6JjoGnDX8fc4NN3b3iZNYJ4+nVTLBavH6brVwjV/
         C3WyG761rjxpjiTtOZCAnLQQVP5hPmyBzIT3v+c/ZgnHKIG+jvZDR/33wC4H1MmLc/h5
         xxUeBZ9kG0NRdqJRd8CwEkhPuwTXC+owOEjkPFSCM45TO9kxS6r9m8nd4Q59ADhWxZjy
         mmiqKhc7g+weQ22unikWPVmZ7c3LBXcdGYsnNnDoYbVbMMVLmTgIl14JoW7B1nUoKLH4
         uzP2fz7Cli8TULWf4Hlls2efLN3bjYe9TZNLvDgbuKtuW5FQuez649zS9YrAO2ok1/i/
         2aCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776150737; x=1776755537; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UEklUAX75lJKcC6L2ltl9qbkuGK/MzM9omGGWWVYxIk=;
        b=khQqjzoQq+DR3kuTF5LN+G6Num4ZbX8vshpGYtsdYJGVCICVjn/vPkBPpmBdAsNyIt
         Klz5qZ+MPwSbLLBSIteQxGdSoBuIPg/FESdfIdn0ZkQnGiqd5+0gsFCoUr9HLR7GYIuQ
         YCmjQ23OBCb5QWz40hwzV7FkyVMil/l9b6Ya4ICK1BX/Q4a4sVp8x7jBk9WKzd6gyHqk
         KpErnBltj4LEMQbAxcYK6XOooYEQJInavuEWGQGqprVEVxq3zKkruIcRVQA2pW09YDoS
         hze6539HC6Vzj4hzB//7GZaXA84x5bs6iI/F9MYmgqdUXEHDKJGK5aAajsIE/4V7RPY3
         GfMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776150737; x=1776755537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UEklUAX75lJKcC6L2ltl9qbkuGK/MzM9omGGWWVYxIk=;
        b=XIAILXHzZKZYd4yzlllrJRu3JowFP5M1URevPtyLu/KSweplw9GqiNlHOFJz2KWC+x
         6HKX0NrcARFnfnC594BCoZNdvt5qZ3kFCzx5MeM/qR53ajPENxcQuC9HMHgo4sdiM3B/
         SSArRGPwvXlXjP/RxcMysjG1LEsf203ZnMnlXH63JH6frwhYQ9Y9oTdxwL3xdzMHiWYy
         2H0K0/HOlQS5hOuVTTngMifTN59JE5ifS5WETUXMNnHkZy3xqi13UYspviC+TZEzjmYL
         BynPEY0A0ILSK1PzLr4gPotUblqYL/+5cRtJUD1XaxXWFqulB8Z8NSyxmikwATvMSfRE
         CXLQ==
X-Forwarded-Encrypted: i=1; AFNElJ8Jhey5mnl8AoeiR1j/0W+SOeIMYBncWHg9x/VctiZFXv7f1+BkkQNw0AOPL0OaGlSelzt2UQv1J5c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy325AsYK90S+bdPW4XFfhfbc8KBtNJig+TIxDnbPw4ZzLMVAE
	YHyd2USQv/1kbd8+qM6XyroaaolmMXzpgxF1XmNRlQelNt7ba6UXYOpS0ZZQ+wVlUXCQQXsXHjQ
	9cJzA9+FfWgbRmHslbYo9qLRfnJzJ3EM=
X-Gm-Gg: AeBDiev07AQWS0dZjaeunOisotvdjFmqhTeNy2c3I7Z093nynIqX2qnSIMQvuaswRYr
	HKZhKHnBEeRwFS6JnWQzNuBBKHsGEDeRM8EJuvAvTrHqwVCvnWjQuNxmzY8nzvBw70M3ytv6d1C
	0G/NKnOp5rE1M679U0i4X6sYwJfdz6pGIH/ghyG7Ys8Z27lnw4LWbI5jF891MgPaEO9N/ACKXWX
	MnZr8fLa0qeQ3YRKSATQVQ/742v2en3eJCzcn5L/jEqIELStLZI9Lx5FgNlabDf5mb76pB9a83+
	/E5SazOS
X-Received: by 2002:a05:690e:168b:b0:651:b5ab:3357 with SMTP id
 956f58d0204a3-651b5ab391dmr9912157d50.49.1776150737202; Tue, 14 Apr 2026
 00:12:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413-orangepi-sd-card-uhs-v8-0-c21c40ec16d0@gmail.com> <f58ec12c-3957-4d44-b823-6a1ae1a1dd94@kernel.org>
In-Reply-To: <f58ec12c-3957-4d44-b823-6a1ae1a1dd94@kernel.org>
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Tue, 14 Apr 2026 09:12:06 +0200
X-Gm-Features: AQROBzCH_H9-7w6mImHbEDf_ELHtA5AMJp2lwX6Y8iAqLMql_XXAAzAws0UviM4
Message-ID: <CABdCQ=NhTkGJUh_fKnZoQMzdpyO-UbV5zrSfiNVUC7bkSBifTA@mail.gmail.com>
Subject: Re: [PATCH v8 0/9] riscv: spacemit: enable SD card support with UHS
 modes for OrangePi RV2
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Yixun Lan <dlan@kernel.org>, Troy Mitchell <troy.mitchell@linux.dev>, 
	Michael Opdenacker <michael.opdenacker@rootcommit.com>, 
	Javier Martinez Canillas <javierm@redhat.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Anand Moon <linux.amoon@gmail.com>, 
	Trevor Gamblin <tgamblin@baylibre.com>, Vincent Legoll <legoll@online.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El lun, 13 abr 2026 a las 10:07, Krzysztof Kozlowski
(<krzk@kernel.org>) escribi=C3=B3:
>
> On 13/04/2026 10:02, Iker Pedrosa wrote:
> > This series enables complete SD card support for the Spacemit K1-based
> > OrangePi RV2 board, including UHS (Ultra High Speed) modes for
> > high-performance SD card operation.
> >
> > Background
> >
> > The Spacemit K1 SoC includes an SDHCI controller capable of supporting
> > SD cards up to UHS-I speeds (SDR104 at 208MHz). However, mainline
> > currently lacks basic SD controller configuration, SDHCI driver
> > enhancements for voltage switching and tuning, and power management
> > infrastructure.
> >
> > Implementation
> >
> > The series enables SD card support through coordinated layers:
> >
> > - Hardware infrastructure (patches 1-2): Device tree bindings for volta=
ge
> > switching hardware and essential clock infrastructure.
> > - SDHCI driver enhancements (patches 3-7): Regulator framework
> > integration, pinctrl state switching for voltage domains, AIB register
> > programming, and comprehensive SDR tuning support for reliable UHS
> > operation.
> > - SoC and board integration (patches 8-10): Complete K1 SoC controller
> > definitions, PMIC power infrastructure, and OrangePi RV2 board enableme=
nt
> > with full UHS support.
> >
> > This transforms the OrangePi RV2 from having no SD card support to full
> > UHS-I capability, enabling high-performance storage up to 208MHz.
> >
> > Tested-by: Michael Opdenacker <michael.opdenacker@rootcommit.com>
> > Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
> > ---
> > Changes in v8:
> > - Resending the series as v8. The v7 submission failed due to an SMTP
> >   error during transit, which resulted in a broken thread on the mailin=
g
> >   list.
>
> Hm? Everything is here:
> https://lore.kernel.org/all/20260413-orangepi-sd-card-uhs-v7-1-16650f49c0=
22@gmail.com/
>
> You can send individual patches to fix up threading, use --in-reply-to.

My apologies for the noise and the rapid resend.

The reason for v8 was that the v7 cover letter (0/9) failed to reach
the mailing list due to an SMTP error on my end. This left the v7
thread "headless" in the archives without the changelog or the full
context of the series. I was attempting to fix the threading
immediately so that reviewers would have a complete set of patches to
look at, but I realize now that resending the entire series on the
same day was premature.

>
> > - No functional changes from v7.
> > - Link to v7: https://lore.kernel.org/r/20260413-orangepi-sd-card-uhs-v=
7-1-16650f49c022@gmail.com
> >
>
> You already sent it on 13th of April. And now v8 the same day. Wait a
> few days to allow people to actually review your code.
>
> It's BTW merge window, so big series should slow down.

I take your point regarding the merge window. I will step back and
wait for feedback on v8 once the window closes and you have more room
for reviews.

>
> Best regards,
> Krzysztof

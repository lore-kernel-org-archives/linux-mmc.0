Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA731F1315
	for <linux-mmc@vger.kernel.org>; Sun, 11 Jan 2026 23:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768175497; cv=none; b=aHvkbsNjkmrJKVCSaw039hwfwKnXVhzmzn4z/pgrbyEsksac3ncWXFteb+a31GTTOZj7PX6Va1iB3O5ZVgwZIdZbMUSkW2Bfv49chEhNjxwfxlQ7yV7o+7NY+Az4L11q2rFSbsKNqa1E/6NKORyxS4VkQCSWQyNKLhxiFOPg6Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768175497; c=relaxed/simple;
	bh=wgI1Dg0jPOPFJlc1k2M53E5Velpu4JrQXL044O8LN4o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tNixRMDfMuricMVojA9Em8ukXN1ICCcW+EhyoJ1qtH6FCVX1YUDzpulIERUvVYdNn2raZxEBBKEGlxxb2Tfk5yHiZpAkchjR0E3RAF5n4QcxzupvjI+G4STUFHnu8NAfKCLEKpinwVO174Jx1Lp7ZPHPN/Cddss3KVk/DuwJFGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jYMrcqyq; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jYMrcqyq"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7c71cca8fc2so3924327a34.1
        for <linux-mmc@vger.kernel.org>; Sun, 11 Jan 2026 15:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768175495; x=1768780295; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D/ENBQX982lICCo3cjSQ7OsIstGG9Mk6/7pP55Ji4uo=;
        b=jYMrcqyqSGRy4sAq7KbadidJl88QbspQp5z82o7Q31zF87bSgL+ntzU09T8/cxHsJ+
         4lI7lkm78mZGTSLOkBulKcdK7niQQKABNe8DpCyjdOC39M/Il3ovHs1Lhh1hl0Cul4NY
         qOXvyyy5w+ewseZiaJ2iWQiu7zUakbkj8QXHJVxDiK4SPjacOuaZt+FIz9JNZfBwc3D5
         wN2ApJfaO/r8y0ouP14u5tIVoj1zl2Bj9I4cTERoJhVDheKwnt95QQ/XOEKC1FvQVU59
         Bb/yaJz28kfZTXfsCAUV1nsN/5yVJkeMnlzFubBq7ZXMTQjyc4SvrUEsTfnuDtEyA+GC
         gfng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768175495; x=1768780295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D/ENBQX982lICCo3cjSQ7OsIstGG9Mk6/7pP55Ji4uo=;
        b=WTZau4pynM/GqU0G6yMuEGQTBugiZ+H2p/mZvqRH8ln38fID+87n8/Bw/atmarkTs2
         B2ImIwUcjf8jiGQ3WNRXGI10qxtY8ISjxLDc6lsRc48l9HgZ3JhcvCuNaEYjSZSuPo36
         RWlo06SEsjNoFkOgP57ux3ya1Lq5FMsXGfLudWggz5okvmphjb8i/73+mGiX3JYv8hz1
         3BeXago0InBe2V/AkYvMK1qDODAdjzqQOvdF7ad3aGGnG5YFEP0KfhMITwLWKtcFNCzr
         ZgvaAq58T0ivga4Nt3Y9TQLtz/3e/QICGAFvMGB/4/VCrj+O+4ySGoU8dJqPcQgUoqqb
         6N2A==
X-Forwarded-Encrypted: i=1; AJvYcCW4AgNywbE0aaUieKXewce2NfUFNQe2dvAZzO7euBoJ5eV6kgDIuqhwFUux89/AFuoJls8hFzb43oM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkxH8RIX2RDaAQMkfTme7/nRCpK0fbV+huAiXdAIw5xThELL4T
	GuEqj2AX9w3HyVBtWK1oEZfprgwpjUjGNxNyBf3JiRO1TZqZXVeFHEVT5WaOUgGPVJQKKuqMrb2
	iyn7MF0QghM0zxdGNBKPnhbqwr8wEJvU=
X-Gm-Gg: AY/fxX6XlsVHVq2mVNw7yw4ZF8hX5+CZb6bzGuhMnfTWHsmtZ0OEjiDbf9ShsfX7/ox
	DHrgLtKfFvrJwLZ/M0LqrHqtm6xJP/Sg+npkNQ2ktNIlJXwiEvzIP4Vwu4bHecJemXsAr/YOlsd
	9fTwC3bg80xs0PlSzsWn2Mmq3lqTFwudNMNyE4AeImtJtJH/Dqu/WdQqFjw8DUREIq76KkC+G9j
	nD/X3GjaIUh4uM2RoLEmA/OytuHdRNCecIusXP5PY9K7XbV7SIJmmfGIdgIixe8Z/buGbvh5fVb
	hYgepcm2uALhCMUjA05ODGwaZwU=
X-Google-Smtp-Source: AGHT+IGlge53U08ebFfe8r244rsrE6CkWTn00e+I2aSY3bW6BvjGm0i6R4xXCnYggHKHg3FXbw80wZStXmjolJVgDDY=
X-Received: by 2002:a05:6830:4111:b0:7c7:6c9f:bb06 with SMTP id
 46e09a7af769-7ce50b7b138mr11464374a34.16.1768175495062; Sun, 11 Jan 2026
 15:51:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260110010715.1610159-1-mschirrmeister@gmail.com>
 <20260110010715.1610159-2-mschirrmeister@gmail.com> <20260111-melodic-chestnut-coua-73e6ec@quoll>
In-Reply-To: <20260111-melodic-chestnut-coua-73e6ec@quoll>
From: Marco Schirrmeister <mschirrmeister@gmail.com>
Date: Mon, 12 Jan 2026 00:51:24 +0100
X-Gm-Features: AZwV_QgRXlN1CiuRYVEhXNkMAqD9Aoc5N6ROQBHLSJhP77NnrQn6dbThJj_qUMM
Message-ID: <CAGJh8eAWNe0JzC7BdA2Rw5etCYgGq3O5Zdgk9zSzsLNv18k=ag@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] dt-bindings: mmc: rockchip-dw-mshc: add rockchip,disable-runtime-pm
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: heiko@sntech.de, ulf.hansson@linaro.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-rockchip@lists.infradead.org, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

Thank you for the feedback.

On Sun, Jan 11, 2026 at 10:41=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.o=
rg> wrote:
> > +  rockchip,disable-runtime-pm:
> > +    type: boolean
> > +    description:
> > +      Inhibit runtime power management. This is required for boards
>
> What is runtime power management? Like Linux PM? If anything phrased
> like that is it is a clear no go. Bindings describe hardware.

You are right. This refers to the Linux PM subsystem and describes
software behavior.

> > +      where the bus timing becomes unstable if the controller is
> > +      runtime-suspended.
>
> You described the desired Linux feature or behavior, not the actual
> hardware. The bindings are about the latter, so instead you need to
> rephrase the property and its description to match actual hardware
> capabilities/features/configuration etc.

On this board, the bus timing becomes unstable when waking up from
a low-power state. This causes a constant retraining loop.

I will move this logic into the driver and handle it as a board specific
quirk using of_machine_is_compatible("friendlyarm,nanopi-r76s")
instead. I will send a v2.

Best regards,
Marco

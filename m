Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA8053383
	for <linux-mmc@vger.kernel.org>; Thu, 28 Mar 2024 13:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711631604; cv=none; b=qrw/kihe57dpaKnuIF2BD3Q7q3RejOD+wHyofvLMI+cn3Da7CRWT3EtUQlLhkt8OHXj9HFOxE4F59u45UukaY4XngknClz7IT3iZulk4wrAypUAmOqTrbq4+LAk8PCYpQewvRjtwLcdzLhaeoQHxONv447FIlIHrsN7DNlX7svM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711631604; c=relaxed/simple;
	bh=Sw26HNkZCDvCbVs0qj/l1QeKOm7+0RZ7psrPy4AQ+ak=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=BZJK0cNLwHzHqknRpejBnumnib9g97tV3ssSItSLeCwrdDR3sMaPNFo/uhHi6Fi3XjpGXWGAvCpcwxZ70jQXoPjpIUWbomVrmL/698n2+az2aC6W5u2bbvm1t1Zzi7G1luamGd5eOd4ExN0XgkYCikhydKO43ryVaS4Q4VDA1xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fd0Y9+uo; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fd0Y9+uo"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56c0a249bacso1210723a12.1
        for <linux-mmc@vger.kernel.org>; Thu, 28 Mar 2024 06:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711631601; x=1712236401; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Sw26HNkZCDvCbVs0qj/l1QeKOm7+0RZ7psrPy4AQ+ak=;
        b=fd0Y9+uosn/yCDLvEN8YSbd5r60v47D5447AuobtJX9Rbot9UpAu14200iKcxvY2Gr
         ybGH3IYC/B9bBfYvw8NlcM1kNCsOeWEnxcYi8XBBzortoiVDfRItj6zgt208xqfJeFRQ
         m1V8OPb5OFVrsCQgseRShU+K4Yf6Jx3KXHV/0LXeprHbsb2bgE3ZbcICapsF4lNK8Rp1
         ZuXa2AgLTbb5toVagDcGuOTjbbpiwsYLO+tTkjmeGKhMK5VtsC8o/mtuiWpDQPGgwbzY
         pMI2ZaZW6EBmkZlXfv2QseIh/u9VnYz4zsAQEZxJXg8MFaNOMIOTBlGjOBkAqJHazcRK
         yYGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711631601; x=1712236401;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sw26HNkZCDvCbVs0qj/l1QeKOm7+0RZ7psrPy4AQ+ak=;
        b=oma05Qcsh1H9IA4g75g89LfhFAabLYHQzYONIrOWJ3af//L3AgnTUC1FgyaNY4L39L
         7WollIV8n8cRbRNI/Pch4C3i0w7tImWkMof6PRQHE0UsOO0JXNhsG43FEY0TsFWS42A0
         eWH8RldxiUT+8L+rV19ffw4WybcGGIoLTNEzkoR7eqGVpKdjSy7hbn676lMy64cgV3Ns
         eajJkO7x5UABAGC3E1Bme0WxjFmjfe5hEpSWSGxuJ08M2/auSj7qq1V0ZLIo9YIpWDpa
         FN0sL9tfIm0fjEO0UlJ6GuFpK5Jr5GSq9XlCYpPetAqqFsRf4wHKkTSYrQVGb400WR+o
         5GxQ==
X-Gm-Message-State: AOJu0Yz+ZNVrMu+BLIPxrkj+g8XYrHVpcA/+TdeN1dP3waC8LeVKpdPt
	neCVjDt8dpaSyPUKNRvmogcsxRiV+V2EsfRqqsyATbQaIw8mKCxwAEzK5G8cspXHRxT828Zzg86
	8mWOFp6pLjgMGKdrd9i4me6+Guz8emUHR5xI=
X-Google-Smtp-Source: AGHT+IFftbwq2fXlGMgnSud/83J6u4sIAeBLRn/QHgkf3OohOmo2XC8D5qjMfvA2j7PAnnRF9mRnWwThTLjVmqGK2A0=
X-Received: by 2002:a17:906:aa0c:b0:a46:7c9c:10d0 with SMTP id
 ko12-20020a170906aa0c00b00a467c9c10d0mr1556989ejb.23.1711631601139; Thu, 28
 Mar 2024 06:13:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Patryk <pbiel7@gmail.com>
Date: Thu, 28 Mar 2024 14:13:09 +0100
Message-ID: <CA+DkFDb7HQukpUyxVemvoH4rXxt3F3Q957EnKzasnehKfbEEzA@mail.gmail.com>
Subject: SD card specification and eSDHC controller
To: linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,
I've got a question regarding sd cards, their specifications, and the
ability to support them by a host controller.
In my eSDHC (NXP LS1028a soc) features summary I can find the following:
- Conforms to the SD Host controller standard specification version
3.0, including test event register support
- Compatible with the SD memory card specification version 3.01, and
supports the high-capacity SD memory card
- Compatible with the SDIO card specification version 3.0

I have found that SD cards compatible with SD card specification 4.10
and higher support something like an extension register and in
particular power management. I've searched through kernel code and
found that these registers are parsed by the let's say generic part of
sd/mmc subsystem not by the host controller driver.
Does it mean that I can connect the SD card compatible with spec 4.10
and expect that the sd/mmc subsystem will use power management
features if the card supports them?

Best regards
Patryk

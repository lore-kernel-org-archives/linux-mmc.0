Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4F42DC775
	for <linux-mmc@vger.kernel.org>; Wed, 30 Apr 2025 17:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746032733; cv=none; b=aepinH+hQWL/q/TWdGxpclI4DjywQCJVmB0nuT6rK2414Bss1Gjtv36AxJdVfjIxu7BDkloZOykiWchlKwd3BJ3P9xn6PwRXx7EuA8LY8IxQjDMxIAb8yCCKRg+1fxdrxlGm5EFUOMclEFJN0sXJiLQaqhclRFbUvLUva63fzrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746032733; c=relaxed/simple;
	bh=BlhnkvAiNFXIzQRX9IBBcGYJLsplmR96ZGKCT9iMLV8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Q/LP07eYmTXLF5iYthQulEZV1oMvkr4xkG7WObOQkp8VlW/xe7XO3hu6I5uvFQyqKKCbqCvWn506XPhPZaL+zJMoVSNEJaEm53xZWbA4FmaDqzYPuAAVrOHzsoUcBN0ayko3iOeq5PDULODOGLLg0C5m9Rrv7GMleYJyFAXz3Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=n4lUk3r7; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="n4lUk3r7"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-72c09f8369cso10051a34.3
        for <linux-mmc@vger.kernel.org>; Wed, 30 Apr 2025 10:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1746032731; x=1746637531; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nzgLHRXnexID2ZP2y6jIKQlRtFLIO1mHssJjwTJJGmg=;
        b=n4lUk3r7lOMhXfkUS6RvydThX4UArvEW2kqZ8uDXhnL1EPOm/ukVTqKXSx8vspLrTH
         fFE65KGR0xx3Rf/FlkcMuqBywzk2QKRaD/66zWrfA7cdeex0NFsLYX3iohsx5iPQOOcS
         NY1qKUXDfuKvG0VdHMpaPbk3yk2UCF2ToXqYQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746032731; x=1746637531;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nzgLHRXnexID2ZP2y6jIKQlRtFLIO1mHssJjwTJJGmg=;
        b=Xe51XnvzggsDa0R3OqAJiIugKOCfkyigpcFa1TsH+Z/vm5qSMGAiCeAupa/T2vfMCM
         YTO49eJKeQxL21Psjk7HxKoyXSRWrapEDR45IkIDqTb3mly+k+HFYqQxvb6Isr8t2ree
         LnxubI2mG/AgOeYZPBBaI6pidDpH4PqS/RQURfgSi9IuyBLXZbOET7p2f4CbzbEbqU+C
         iFH5ArKEqYkwBzRTcbVxHIw+K2kI0K1YdIoLDiWzqGc9RGk+Feqjt/Y3kGrV+RszC+ki
         8WRE9lpgda2PxF4/AXga8Dqmq0Ts7hEN1MCkWcCyO98jpG+ayA1UcQO46BQcYW70I7zb
         Rs5w==
X-Gm-Message-State: AOJu0Yz5+939QaxAaBSvgv9ZNLnU+RujwIn9fdIwZk5LNhosK54rPuEp
	sn7lUfFsgk69/ZzIoyDoeRf+xlnefoygi1KKnWg362arFnKHQAKCSfeIUCNkKnklj+UL3TUT7rV
	IMDkEIOpJVKwtOXew4PZ2iAJNXkTnZJEfX9v+7ZJSYqBAxDpFtNg=
X-Gm-Gg: ASbGnctDI3nSOXslWLrzZwIuxYuqXUtrXHui+0NGN8CAEijG6s2qtbBDAcSdm3IHMj8
	xmQVXAREo0KGAScYN73PFFUu+9GRaViLXINQLsUM3uixuuuCtE+rjSrxe2zHG3bwfx7lBKZswxB
	5rIYq6KhlYGNBTvBisRxaP+MTBSWVQ5w==
X-Google-Smtp-Source: AGHT+IH8PwEMUgG8GAU26XyZrEwvYYAK9YcBzom/dnCu4bGQcYPmX3lob/pBdAZRPH5wV9ogxZRQlL4Cu9CKvZ3qbgk=
X-Received: by 2002:a05:6830:398c:b0:72b:8c5a:7294 with SMTP id
 46e09a7af769-731c0a0681amr2783766a34.9.1746032731118; Wed, 30 Apr 2025
 10:05:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date: Wed, 30 Apr 2025 19:05:20 +0200
X-Gm-Features: ATxdqUGdRv3cDUvIP4Xr2ZZiD2wUQGSD8tvjN7UPhR1eHsx_Id_9Hpm1B6p1u1M
Message-ID: <CABGWkvp-peEfhc57-+g+_w4DWWqdWVgw6CFF0tS7yjGsTtTufQ@mail.gmail.com>
Subject: RFC: mmc-utils versioning
To: linux-mmc@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Avri Altman <Avri.Altman@sandisk.com>
Content-Type: text/plain; charset="UTF-8"

Hello Ulf and Avri,

Would it be possible to tag future releases? That way, Buildroot's autobuild
service would automatically notify the maintainers of the package of a
new release,
and in turn update the package with the latest changes.

Thanks and regards,
Dario
-- 
Dario Binacchi

Senior Embedded Linux Developer

dario.binacchi@amarulasolutions.com

__________________________________


Amarula Solutions SRL

Via Le Canevare 30, 31100 Treviso, Veneto, IT

T. +39 042 243 5310
info@amarulasolutions.com

www.amarulasolutions.com

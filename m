Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EF6205E20
	for <linux-mmc@vger.kernel.org>; Sat, 20 Apr 2024 03:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713583033; cv=none; b=tfy5h6nehydszlz+Y4buxcUS8tDTS6TWAHVS3PMjHBdY+5JlQ/R3z0Vnu/lDLw2L0WJOevaypxzhPUFWr4IrqwLpLNSN/acsvdAxhNpMSXbsUWJpq3GXRO9HxZeGKuviMOz+atc25IiavUoenWwHuE15TJ64PbMqL5weFT3GDRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713583033; c=relaxed/simple;
	bh=Y0ioPf96ra76VdIj0Uq8fsS6rkezFF76eyr/WXtONRc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=fNqwbymWCkotbi0NSQHF3fvpuT/MRzSJY3PPBHpjMmKuo/5DcUbMYWf/4o8Z5TacdNXo7TzFGJRoOFtrnK4vAx2ySVJ9qaKmNcc+kZ5d3GTLze5UBdjXsMehxNDHJr45ucl0aPRd9FBXNY/DGuIbmuNvoSCap7LCVk3IeVLyB/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ePdYZauL; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePdYZauL"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5aa2bd6f651so1718585eaf.0
        for <linux-mmc@vger.kernel.org>; Fri, 19 Apr 2024 20:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713583031; x=1714187831; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WmRaTnDAcFffZP3ZoHTwAf1AyMM8S5cP+b9n6un0gcE=;
        b=ePdYZauLKdxDFAbZQiI5E5o+NdZSYnTgBXN6qm4zBqwvmnP4GxsyTEB/z2ngmbK4Fa
         hi0EN3shwF/2p8TZ9dIPHJ+aNDq5exmi90F6OXphfGp/1J3l8Pr6sYGQnynAtjX5etb4
         5bPUi/avtmMn0kMTTwWc8nfkiEEQ9VmCByXLe0rtZfax57XGrBbsFNhNi+kt6zSYkXRa
         KEIUFaIwrw/f71ni7nBaacJM47icDZAhjDseGXlcdKz9Vl4NDxLWbGH/PxefDH7Vb+Sg
         gLCRYxUNjR1x1bJcDCIAwDyJFad01lVrVqIYHumkphjkQYKwIvS3QvLrzkbo28E47rZx
         4KMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713583031; x=1714187831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WmRaTnDAcFffZP3ZoHTwAf1AyMM8S5cP+b9n6un0gcE=;
        b=d+CGgyEolJ+FloLGeiXETE0+hLpEIyav+7hd541m9HgBeP5P4EUW8m3kxIO0T1+qPi
         gzXozZuHexZYEWOPhxf+FI1f5Z50Jm75M4h3SuMuQ54iCEFdllIODcG7nZtvi3bF/HCS
         +oK2FPXhWAjNwfI30zz++Oi0szi150SAAluR+uV6HYCZ2j9nQk6/LF2DkvsbS/2Pi/Fx
         t8vHd/D5UOqYH1jmCgMVTnMoWxCNBpEaiUpFVU3TSUWFXkZXUOj2VJPeb8PZbVQKi5G3
         5J8qVlZKmnr31ASABTTQ6RzBoFDvU9x8gWDHviXo5aCDcmTPdmzQD/crfaAI4N8sjLIQ
         7v6g==
X-Gm-Message-State: AOJu0YxiG7eCOBTpupMAV//gvIS5kQv+misAGjBQaMfbEoKsidpCEurZ
	o5i2ew4souEe3lXkvbJ1WroS71OU7o6XYKoC+mpg2lzxR9uIfOTuWxMC2MrDLHGphDlgBfF5WQL
	R7NlGojvlZ1P9lRPANJ3q9mw0hT56J3Sm
X-Google-Smtp-Source: AGHT+IEFhBx8DDJKzxNgEG1oOfowRyIzUGO86tvVAv81PSWaXMl+VlHOVSPkbsBQxGcYN+dJYR0kOnQyX6VXCy/oqiU=
X-Received: by 2002:a05:6358:7b93:b0:186:f45:391a with SMTP id
 n19-20020a0563587b9300b001860f45391amr3721024rwg.28.1713583030723; Fri, 19
 Apr 2024 20:17:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Zhan Liu <liuzhanjobs@gmail.com>
Date: Fri, 19 Apr 2024 20:16:34 -0700
Message-ID: <CABqN7Bz9ajpsVP00sYkRRyOaTujGALwG30rVAwnpgzoOrC3U9g@mail.gmail.com>
Subject: [PATCH v1] mmc-utils: makefile: cross compile
To: "To: 'linux-mmc@vger.kernel.org'" <linux-mmc@vger.kernel.org>
Cc: Avri Altman <Avri.Altman@wdc.com>, Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[PATCH v1] mmc-utils: makefile: cross compile

From: Zhan Liu <liuzhanjobs@gmail.com>

Problem and my changes

Current makefile can only compile for local gcc (x86). Add cross
compile so we can easily compile for other platform by doing =E2=80=9Cmake
CROSS_GCC=3D/path/to/your/cross/compiler=E2=80=9D .



---

Signed-off-by:  Zhan Liu <liuzhanjobs@gmail.com?


diff --cc Makefile
index a890833,efb2ec8..0000000
--- a/Makefile
+++ b/Makefile
@@@ -1,4 -1,5 +1,4 @@@
- CC ?=3D gcc
+ CC =3D $(CROSS_GCC)gcc
 -
  GIT_VERSION :=3D "$(shell git describe --abbrev=3D6 --always --tags)"
  AM_CFLAGS =3D -D_FILE_OFFSET_BITS=3D64 -D_FORTIFY_SOURCE=3D2 \
            -DVERSION=3D\"$(GIT_VERSION)\"

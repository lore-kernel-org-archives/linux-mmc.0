Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9034C1F869A
	for <linux-mmc@vger.kernel.org>; Fri, 31 Jan 2025 20:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738355120; cv=none; b=NR+osAhv/HnYZq6nxrnYr7zyEMyBi+lIXKCU68D+ssn5wwyKpAsQUQCg48UGRSac4556eS5wiVYgJ3puTN3ly6pEUyCKeinx5WA/o6hNFG+IXSsbesJFfccrhrOIPmOcyVeGVzWdxpscCcdcufmxsZelRCPg0K4f5yoL6VRAnzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738355120; c=relaxed/simple;
	bh=rmBWKBYHCI+WuV2jjWYGUn7c5T236U0xlpQEPpz0oeY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oWjerb7oBRIoEbIImcgW3GmSxK8FRTExUyi1VXV5l53CBgwMTrMZsmOHfS9s1dDEc5Dc/FnOmH7dHVnQOlWBlQEmIMBGCBkK6vpCo6o0oA+/YqehD4NNmS7NhhP79Ezd/F/JTtJX0Yu4gVQ8R6dposJVmPaWDzIM+8dwhyATNE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=s6wxqIkH; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="s6wxqIkH"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-29e842cb9b4so723718fac.2
        for <linux-mmc@vger.kernel.org>; Fri, 31 Jan 2025 12:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738355117; x=1738959917; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FzzIwzQtyYUR99JIrJ6how8p6bj9KukV10X1RHN4Hv8=;
        b=s6wxqIkH1D9BN7+dFKiVfTcWWUarvgFPerBjQBy2NCE81v48dt3r66cfJ5wtOQ/LiT
         PzJg2f0V1gkwEImOdpkVpgU8AM/RLxz5Yp8VdZT+gXb7II+fyULczC9ffD4/Rq0p+WEr
         X5lbmVf3N1WdV+WTfAOiA1ZdqYc8frmtJxKxmU/7Hv1rDXeiNfReGh2nl7dvUtOYPfrW
         QpIB/BIY4NB7jyxCkAPzlo0R+x8sTudxVaSVqlzpwMi0EpHUtGcDJVqkDoP4UGtxYXRg
         Q07OAtIcAT8tRFMvvVrQ60DJmzpBTFdHI8Q5YjebwR34OUPgteE5yDJftgmc9pUg+HwJ
         Tigw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738355117; x=1738959917;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FzzIwzQtyYUR99JIrJ6how8p6bj9KukV10X1RHN4Hv8=;
        b=ZlIV7fK7FeM6sOERacBFpGMqDzIgB3M3xIMc+/HvhDuzshxnFoDpjImlDIKJ9HdwwQ
         A58saVI4QDTGRcj3pahqiUtxxEve0zz5ep1GcucHG11h5P+qNycqhYAgcKEnQX46lZYZ
         r68k3BW3unv++ovWOgArwsplRAscaCUWonZN12r09kMBMwj1i+BPF8DTtmeEZlWtgB2k
         N92Q4k1dluYJqHWm9R5Dzy1fovcXZS4tQbVxkaGkis94Fzis0/xzMaUMErMVt0TVa1m6
         CFh98UGdqey4B5zdgf3T85gYCyiuXx5i4MXYT79QmGTE3Ke0SWjL/K1TwC14E8EWhbYH
         5xCA==
X-Forwarded-Encrypted: i=1; AJvYcCWGt5Qh2TRTnsXcOZADnpO3tVGCnOCg/2mnP9OZMDgTyq3VDtSvUmDd+0lOVG8BdvxhDJJiABLLdu0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjueT4cGzNh1Swl8ZTCI29otIRFkZzi5/lQDzajDHtQjAm+2tw
	GquWamDDNV70uQMJ1o3KAo8aJmdq+rojydxloCc7GACRWejzTzcoawD9AF1GUxc=
X-Gm-Gg: ASbGncsdXWBZ7Nu5Z3SSuKueAr46d8x6C3xxJ2mtRCbxevy/QmPflQChbDbwzdqMVZO
	Gn18yebDlLmn+UIcDgnfHywmwf+kX5n4+kHKwA+hTxfVfaLp5AToOauztyMIDJuH9BTdvcHa7Cv
	A66YLvdg1D9mOKHGxUxwzfh/m5jmw02z0D24ovAUzMpWnmFWdohQrOcGlErB8QNDz25RR2mSFG3
	f48aPHPSEb0z+qV4n9DrHehZxn8o2f+mGrs9xkzSrknQRVeQKnAf/i8kzaPm9f3D17V18ft+uke
	djjTKFd3OWGqc3XOePx3Mm0Ehk1uIsGGioUGEiC/AoQ6ncI=
X-Google-Smtp-Source: AGHT+IERsKIHS0RESeT1aGghrd2e2VbJU3Jew/L2qRirwk6axnCtq0WNFwypLdr9E1c9DhZObl9GKw==
X-Received: by 2002:a05:6870:32cf:b0:29e:255e:9551 with SMTP id 586e51a60fabf-2b32ef5a830mr8108456fac.2.1738355117684;
        Fri, 31 Jan 2025 12:25:17 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b35623d2ffsm1403157fac.22.2025.01.31.12.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 12:25:17 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 31 Jan 2025 14:24:52 -0600
Subject: [PATCH 12/13] phy: mapphone-mdm6600: use
 gpiods_set_array_value_cansleep
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250131-gpio-set-array-helper-v1-12-991c8ccb4d6e@baylibre.com>
References: <20250131-gpio-set-array-helper-v1-0-991c8ccb4d6e@baylibre.com>
In-Reply-To: <20250131-gpio-set-array-helper-v1-0-991c8ccb4d6e@baylibre.com>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andy@kernel.org>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
 Peter Rosin <peda@axentia.se>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, linux-mmc@vger.kernel.org, 
 netdev@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-sound@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2

Reduce verbosity by using gpiods_set_array_value_cansleep() instead of
gpiods_set_array_value_cansleep().

ddata->cmd_gpios->ndescs is validated to be equal to
PHY_MDM6600_NR_CMD_LINES during driver probe, so it will have the same
value as the previously hard-coded argument.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/phy/motorola/phy-mapphone-mdm6600.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/phy/motorola/phy-mapphone-mdm6600.c b/drivers/phy/motorola/phy-mapphone-mdm6600.c
index 152344e4f7e44de0f8ab1cae6ae01a1f1c5408e9..8243bab6ac3af2ee1394ef743aaad12a19c8ae36 100644
--- a/drivers/phy/motorola/phy-mapphone-mdm6600.c
+++ b/drivers/phy/motorola/phy-mapphone-mdm6600.c
@@ -177,9 +177,7 @@ static void phy_mdm6600_cmd(struct phy_mdm6600 *ddata, int val)
 
 	values[0] = val;
 
-	gpiod_set_array_value_cansleep(PHY_MDM6600_NR_CMD_LINES,
-				       ddata->cmd_gpios->desc,
-				       ddata->cmd_gpios->info, values);
+	gpiods_set_array_value_cansleep(ddata->cmd_gpios, values);
 }
 
 /**

-- 
2.43.0


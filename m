Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A62C397680
	for <linux-mmc@vger.kernel.org>; Fri, 17 Apr 2026 13:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776431488; cv=none; b=Zy4eKZBWOKEfkrwCt3ow5Y4QkoBCISsiv/1O2Tx7S+UxLAzyf+Dw62LOXWMsYkOuoaRs16LFRY164HLZbEYI6tp3Qoj8jbxmZt7phWMSRbbZ7SaqZz0o0us0U8HpOA5BqyZs7SkHAMhsDNo2nGcwBm0ysApxVJeqbV3YLYEdqXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776431488; c=relaxed/simple;
	bh=Klkglyq/jaqn07LVoY+DygFKlFSeY4mf3uyDS+66nUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UzUoc2JVECNhWCKfjDvP3UuKsN9Py/lEnhhht1MwnH/I1G62gurXuPe2LxMO4WfGzalTIvlH7LwB4BC/fpo2gknErVS5RBhoG9S4WHgg0q1BgPdTcyXm34Dsv78r5sABuNKxrA/L5Rp+lZ14fPm5vhCJx2znUXuA+C6XwYLA7M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=kgat+i2O; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="kgat+i2O"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43d73422431so500098f8f.2
        for <linux-mmc@vger.kernel.org>; Fri, 17 Apr 2026 06:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776431486; x=1777036286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yLBJQur6L6abrgINbvpQqXST9x1YXfxN6XkkI5ZCGzQ=;
        b=kgat+i2Oa6Wy9zEOI65gHK3Zn9aMLrxwt/mf7bc7zAHG2PcE2wWKWhs+3MjkbcCAuz
         sd9N3EZ9kSFwUmKa20GXjKUvoKsXqum9lZAHIMOR+mVXLGphlnSmAjNKK776hHo3meip
         EXzDLnetciMhyrijIbsYGXjGhtibipFdHPOOjbaNzwu7LYQpF9lH8Jwt5JK3mGczK6Bw
         6NMX4UmX0cqrdoitSk2b/Bn/QR89mLBjpoLJKkTwMKYlKX9gXxl5GQJ6mBjICKg6OsGp
         mbr1S5TM5yOF0ZQyapKPlZJnpvZnFqeGo+JZAE9NUYV0WczLVAnuxj7fFSOYRgbknC+a
         IGdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776431486; x=1777036286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yLBJQur6L6abrgINbvpQqXST9x1YXfxN6XkkI5ZCGzQ=;
        b=dNWtZKEk7F/y2aWdS+/WXwCfx2j9gr/EbT7Ug96HmvWj7qSJHrnxNTgZehahcxU5V5
         Wll3MkuE1G/sexRNzoVio5DNiYdAVxxUU7BG3PY/5cwHWy8n9mJV23zMOgCldWWD3ZN1
         9Bm5L+sxt7hOeFaKY2uWyxWZmA41OIFzQib//UK0ZwKGw5g3sJD8r16WJu3b0DI7nhSU
         q3yvcz2D3qe5f1xj4SA7YXJkwbM7vIIxeRBvWUZAetFKMxznLRSe0nZ28f8UPxslGy+A
         T0XxukTex5iuGFHqsVgtWJ3Qgk4LIK+DQ52sdN0CdqwEIyGKtfNq1u+y0JeYQRblm5Ow
         GQpQ==
X-Forwarded-Encrypted: i=1; AFNElJ++zG2zxB4JMXpHmDj51qi0KtdDoZKXiFV6JFyfZOV7r8A4bIM3ArXUY+tucqjNGvaVgT3zvtcAL5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ435ovXHpp06qdGlUFV79R+Z4XqmoRy4zyssHPz77PfE+QFOR
	I26Ezw7jHbdPRNq9p2k/2lJkNKHwR+5KSM5LGYTDfd+BX53kgvgZRcn7Ch8v6NQSXYE=
X-Gm-Gg: AeBDiev6YUBW6R4aIIV/aw4rLyAhsn8/g5a6jaXqFjQi/rtJXRh3K0jXPTEeQGmBN9r
	N6kZTQL5r6cw04VPXIyXmhbeWnaY2SffxC2rJlrjOOx0hPz5mutKztcM3M07T41K4Ph5aGMljXP
	DUfohJpFOqN9/RNTZdO0PJEgWkpUKovzFtOXgZwxCyVEni8kZdQkzwhzu5G/ev0KjCAR9cH8Cr+
	WmYFF2zR9eyVB/V/HPHfR5XIwS2kFWGGhobagRP5WjpiYPgcthmG6l2Slesx6WOc3u81ekCwvfk
	1WIM1p7//eTN5nE+P7dOhWv2GbuWtNBr83Xz+EqhB2pLC97cR36gHIGykag2KG6Kvdsf09/j7Qn
	1iia4aIWKJvYxapo5bYvO8eKS+HY41+NLk+Nh/3wc2WVw2pcuB45UBGbAZiJv9/i2CoT6eflqY6
	ST40tJVIFWdesQfCZwrfje+gmEJjUAaLbynVXCiPtm37jXEuIznS0TDyWOVz7x7YNCKZnpx97c6
	xUCgeydSBO8voFSHu8ZIt+x
X-Received: by 2002:a05:6000:420a:b0:43e:a69b:d813 with SMTP id ffacd0b85a97d-43fe3e0d459mr4571980f8f.25.1776431485775;
        Fri, 17 Apr 2026 06:11:25 -0700 (PDT)
Received: from localhost (p200300f65f20eb08db61cfc60d8aa232.dip0.t-ipconnect.de. [2003:f6:5f20:eb08:db61:cfc6:d8a:a232])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-43fe4e4daf2sm4238766f8f.33.2026.04.17.06.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 06:11:25 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: "Christian A. Ehrhardt" <christian.ehrhardt@codasip.com>,
	linux-mmc@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-kernel@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-mediatek@lists.infradead.org,
	Ping-Ke Shih <pkshih@realtek.com>,
	linux-wireless@vger.kernel.org,
	Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/6] sdio: Add syntactic sugar to store a pointer in sdio_driver_id
Date: Fri, 17 Apr 2026 15:10:47 +0200
Message-ID:  <c830049dcfcd99f005e2ff6742aace9341c61f13.1776429984.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1776429984.git.u.kleine-koenig@baylibre.com>
References: <cover.1776429984.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1594; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=Klkglyq/jaqn07LVoY+DygFKlFSeY4mf3uyDS+66nUI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBp4jFZkxQbj+KYt4Q9fEkJxuokeQF4k0Z8QVO3Q 7wAQaupW5KJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaeIxWQAKCRCPgPtYfRL+ TtZtB/0YGCqVt5rVpLrWqCD44F5LfNFUgv/+TGPxayzQfsH7zoCBqE9UgsVpBkFZprUwAzLBPWG MPbj74nUaxJfky/T/6x/bsJ20CXFl14Aky5oeSqWXwpx/STsvR1t7BH1meFZ1chEsexFTdIwswa 8F2lrrBsAe+eGHk4UdYwOcEBLke8MRKu7X9WInf8735NDYlo6VkX6TwaQTxpOcTlNIDfwZlA6ON nlrxK4GTkQYXCmaFZYylJBpOTDYLdH8GJZthPQhYPW5w9D8jVeVUIanYYaSikHt0R/zyWaylAij O7+GqKklrjT08jMFR3/4DzejRKFhjlyBUA+HrbH74dCapvBS
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

On all current Linux architectures sizeof(long) == sizeof(void *) and
this is used a lot through the kernel. For example it enables the usual
practice to store pointers in sdio_driver_id's .driver_data member.

This works fine, but involves casting and thus isn't type-safe.
Additionally with the CHERI architecture extension there are machines
with sizeof(void *) > sizeof(long) for with the traditional approach of
storing a pointer in .driver_data doesn't work.

By replacing the plain unsigned long .driver_data by an anonymous union,
most of the casting can be dropped and it yields a working solution for
CHERI.

All users of struct sdio_driver_id are initialized in a way that is
compatible with the new definition, so no adaptions are needed there.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 include/linux/mod_devicetable.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index 5b1725fe9707..0eb5d196f5b5 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -414,7 +414,10 @@ struct sdio_device_id {
 	__u8	class;			/* Standard interface or SDIO_ANY_ID */
 	__u16	vendor;			/* Vendor or SDIO_ANY_ID */
 	__u16	device;			/* Device ID or SDIO_ANY_ID */
-	kernel_ulong_t driver_data;	/* Data private to the driver */
+	union {				/* Data private to the driver */
+		kernel_ulong_t driver_data;
+		const void *driver_data_ptr;
+	};
 };
 
 /* SSB core, see drivers/ssb/ */
-- 
2.47.3


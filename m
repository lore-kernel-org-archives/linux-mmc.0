Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F3F214237
	for <linux-mmc@vger.kernel.org>; Thu, 20 Feb 2025 20:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740084899; cv=none; b=fT/F65Rl0lkmYyfv9c4GffYHpYY2gNMQF6eReBsujLqrPwvooSVfI+tmjJsoJKOLT/JXHGH0qKK6GFMvW12vbkukodNM3x3GwGJV6vHmOCY31U9aFpDby/pY50SIa6vzezcKVWmH6irOcrq/zaSFhoQ3AQ5saMCuE+fEYlm7z9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740084899; c=relaxed/simple;
	bh=Xc6o9obrZeidO3IrZs20EkZMwxxHvxTSWqEyw4C1voI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LUfjoClW/qdemcC8PLUZNHywFP9NoiPbF9Sy157w7eEPa8NXYitj4iE05s+LfzNlm2IBfHrGJcJxqbqNSPyL/HXd58z+KPnQUDIOMJza73ps6TNvI3gGL7/j54wYcZ+tZQ0CxZ+dowYvfRGbM5srYzOBxjcPuKCFsLwwfFUTMcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=1dXXBJPK; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1dXXBJPK"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-72714016741so780434a34.3
        for <linux-mmc@vger.kernel.org>; Thu, 20 Feb 2025 12:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1740084895; x=1740689695; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lmfqNhipvTzpaPHouDLPUPBFfenRqD8FhVYBJFNu3b0=;
        b=1dXXBJPKyl79MFL5kY+SZTVMp8uVM+kote9OOwmFCgKZymBx6jdSxG8PDQiRLbSRA8
         tH+rTa1uqbAqzck8hq68ndXav2GgvFsjPdcV3XtjmJkCwuL2xLawOFMQswMJpB0a/67a
         Zba8pUzG4LM8ucZ3o4Z4NM0lGhYGAnfbrqjeR2H5p4duEGR3wfJZdqEwPeymH7TMOR+y
         sDk+n/NvSTlK/+2CYwbjl83wPxNd1wGvgyWbuAilVBCYBXDjFdxsa+mIEPU9pmahYppL
         f1HdT8HaJPAtIZpPTNwwJHTQluH/ByMUCFdOOgB3wV+bKts9xv6E254vB+tiTdxv3tm5
         08uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740084895; x=1740689695;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lmfqNhipvTzpaPHouDLPUPBFfenRqD8FhVYBJFNu3b0=;
        b=q3dvxK9uwh/LcyPsixNRQ6W6cyYnh20sXNojQheRFTZAJ0UIUOWeVybr3LOe5XUWT3
         Is8V2qwu8dzj2HKVk/KtK+0YtBIlUnrXehZWZa7oP9MAaCmqAvgJJtG75VhSj4GPDnpe
         G2Hfjy1BuEI3YF+HcbLs0/boOo01nxru321T4uxDvvVUf6mxt0zVDsHQW29zBGt32BHz
         fZWpn33pE+ZeeS/K/5uz/nETtxKASgUYPsMD0JLPHSxuNzKp8tY7NnrFFPWpjAST7b5A
         ix3+BTYgY9aMBQZ/aO+epewZX3o4bW6Kiogbn2mA3MDR5jciYawVK/Ebccuvn7cm2nO6
         VRWw==
X-Forwarded-Encrypted: i=1; AJvYcCVYUF6TpYWqNamMdUCZuh6//3jWiqdPrp5fvsGflmVKeLV8O2VpOna7hTbcNL9+RnEcJyYPCEAiDgc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/ShG59Ov9JVLgrdt5ZkXNbLpY5cSPOvUOD3nkcAnkVfkA7zT8
	+XuYpYfJP8vkLxwjKW01ZeKNGlx5LhFbdxkkTZDPVGK4ikR33HfG07eNs5dKE+8=
X-Gm-Gg: ASbGncsv/T7qAN/pfvXLzqkaJ08iRVGOqEtfMXGJvX1k4X09NEKC+AVJ1qa+BJZmUJX
	He84/SPztMW0vt0QHGNTmj5viFWgfAwEE0d5spp2OlbBKj5CERL4Zb3mQz4YrAZzB2fUCCQ0Hhq
	5t/GHbruPXGtX8tnghtm5WeFOsBYeICgMVaONcgVEpOiQiz2WGlRSxEV+SjvE+VNr+mesBAMTmG
	jirOwI9IST1cq0F/bOljvT6l2njH/wKVqn9kOHyF+qZvrV9z5UfbkQFljJXhMuplJU+Ju/pFSH4
	oHxDTZ5EfNEe8pWMJZYHCCYBVmISAHkpqrJeH7mc98akEU+i+o5g
X-Google-Smtp-Source: AGHT+IF3mi4w+ioATe/neRX31NhU+G5fVnUO+U3AY+NTTkR/32/joj3J25iUisGaUZnzV5dytcgeCw==
X-Received: by 2002:a05:6830:3817:b0:727:4439:2079 with SMTP id 46e09a7af769-7274c563e6dmr324973a34.17.1740084895336;
        Thu, 20 Feb 2025 12:54:55 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7272a3751e0sm2223640a34.58.2025.02.20.12.54.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 12:54:54 -0800 (PST)
Message-ID: <4052fd7b-dd8c-4a5a-8f82-dd515de14d20@baylibre.com>
Date: Thu, 20 Feb 2025 14:54:53 -0600
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/15] iio: resolver: ad2s1210: use bitmap_write
To: Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andy@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Peter Rosin <peda@axentia.se>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-mmc@vger.kernel.org,
 netdev@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-sound@vger.kernel.org
References: <20250210-gpio-set-array-helper-v3-0-d6a673674da8@baylibre.com>
 <20250210-gpio-set-array-helper-v3-10-d6a673674da8@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250210-gpio-set-array-helper-v3-10-d6a673674da8@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/10/25 4:33 PM, David Lechner wrote:
> Replace bitmap array access with bitmap_write.
> 
> Accessing the bitmap array directly is not recommended and now there is
> a helper function that can be used.
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  drivers/iio/resolver/ad2s1210.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/resolver/ad2s1210.c b/drivers/iio/resolver/ad2s1210.c
> index 7f18df790157f1e411fb70de193a49f0677c999f..04879e6d538bce664469c5f6759d8b1cedea16e9 100644
> --- a/drivers/iio/resolver/ad2s1210.c
> +++ b/drivers/iio/resolver/ad2s1210.c
> @@ -46,6 +46,7 @@
>   */
>  
>  #include <linux/bitfield.h>
> +#include <linux/bitmap.h>
>  #include <linux/bits.h>
>  #include <linux/cleanup.h>
>  #include <linux/clk.h>
> @@ -180,7 +181,7 @@ static int ad2s1210_set_mode(struct ad2s1210_state *st, enum ad2s1210_mode mode)
>  	if (!gpios)
>  		return mode == st->fixed_mode ? 0 : -EOPNOTSUPP;
>  
> -	bitmap[0] = mode;
> +	bitmap_write(bitmap, mode, 0, 2);
>  
>  	return gpiod_multi_set_value_cansleep(gpios, bitmap);
>  }
> @@ -1470,7 +1471,7 @@ static int ad2s1210_setup_gpios(struct ad2s1210_state *st)
>  			return dev_err_probe(dev, -EINVAL,
>  				      "requires exactly 2 resolution-gpios\n");
>  
> -		bitmap[0] = st->resolution;
> +		bitmap_write(bitmap, st->resolution, 0, 2);
>  
>  		ret = gpiod_multi_set_value_cansleep(resolution_gpios, bitmap);
>  		if (ret < 0)
> 

There is actually a bug here pointed out in a similar patch. bitmap_write()
only modifies the bitmap, so this introduces an unintialized use bug. [1]
Here, we only use the bits that we set, so runtime behavior would not actually
be buggy but still best to fully initialize the memory.

I'm a bit surprised that my local compiler and iio/testing both didn't catch that
since GCC 14 caught it in the other driver.

[1]: https://lore.kernel.org/linux-gpio/20250217132152.29d86d6c@jic23-huawei/T/#m3163d2c5db5b7376504d8ad6f23716f1119de761

The fix is simple, we can zero-initialize the bitmap.

diff --git a/drivers/iio/resolver/ad2s1210.c b/drivers/iio/resolver/ad2s1210.c
index 04879e6d538b..ab860cedecd1 100644
--- a/drivers/iio/resolver/ad2s1210.c
+++ b/drivers/iio/resolver/ad2s1210.c
@@ -176,7 +176,7 @@ struct ad2s1210_state {
 static int ad2s1210_set_mode(struct ad2s1210_state *st, enum ad2s1210_mode mode)
 {
 	struct gpio_descs *gpios = st->mode_gpios;
-	DECLARE_BITMAP(bitmap, 2);
+	DECLARE_BITMAP(bitmap, 2) = { };
 
 	if (!gpios)
 		return mode == st->fixed_mode ? 0 : -EOPNOTSUPP;
@@ -1427,7 +1427,7 @@ static int ad2s1210_setup_gpios(struct ad2s1210_state *st)
 	struct device *dev = &st->sdev->dev;
 	struct gpio_descs *resolution_gpios;
 	struct gpio_desc *reset_gpio;
-	DECLARE_BITMAP(bitmap, 2);
+	DECLARE_BITMAP(bitmap, 2) = { };
 	int ret;
 
 	/* should not be sampling on startup */


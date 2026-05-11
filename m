Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2CA371CFF
	for <linux-mmc@vger.kernel.org>; Mon, 11 May 2026 14:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778510074; cv=pass; b=lan33GCh2K85rkPkAFtLntJq5ykmVMmHlpS9wjBL5xOIAk4K3AV0uMvpFiF5zEBNB3rzFFDDiu0jpOkc/is3RTiAd2mJieNGhASowoFWJ+rKfG3+uEuhV5dZGOtv6THGHD8HWbhkNlhvZLdFbCbiYjc7Eg4/KkhkQMD1CTalj5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778510074; c=relaxed/simple;
	bh=vD7AonEnJis4H4yYmplk1jKeBBiHyHkWqatkz2fEvwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uKPeWZ2PdWOBvWrvn0srgXzoQO8oLz4ML0lupoGbtHSM28GaVrtYD++7h+XlH2Eoflbo1y5fKaZWPgGK6OhteyxEulWecMRuSuKAEwoHcO+00juFfeAMxsCqQ349dAT0fuPDw6NFd0Bq6fFxzGCfHOgL732LttWJvSFE32gl3EQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Q5acmmuw; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q5acmmuw"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-799001d73bdso29877787b3.0
        for <linux-mmc@vger.kernel.org>; Mon, 11 May 2026 07:34:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778510071; cv=none;
        d=google.com; s=arc-20240605;
        b=COPw4WPBefKZtC0bjUsXlhHJnbzpCGUlleTtJ0bfHPwS1yk+hrD2WiNuXYCxN2VQik
         MoCAicASmPfGN8Yxe8p2VFVa+exf8cdIs5Xhg55vD73H4ItN+QmLVDsq+u1hrZbyt2yI
         Ar+93tOM4rym8rvhKjK6klIE7vmKJkJXtJgIyTPpThbL+OpmatSD7HThuLtTNhPHqr6p
         aqN+YtCvErYGMYW0OWF8mQL1cDDoxHOAzOfzzuij0iZnJPwRe2NcLfm4LP2nul3wYblv
         5QRVH91xb/mTogrqmeBe7EVW09CtqEfH0sxWsynSe0HXOnfEQkxcXbSnPX/yASv3yGzS
         0TjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+v2ay7d5zaezO4LQdeMSaE6xJKDm17at2Vx/sGq20mw=;
        fh=1qi49PJr5CHHA3VOdKTRT2jhTNKiLsNgmvpJGCY2gSY=;
        b=WOroxvh9WYaPhyHTUoVFsVtHoCPZDg5wCc2kQJPaBn4pjpRiw3QjrLfZjICMuHL+1F
         hEoL1NoNEerCU7uxJwq0F1VoSd2B5T5GLJlmiuhfNCt/gdlEh5hlzScbBGPTQl/mVgnA
         Mgzh8Est1IT+NWG5Uz9/5Ih/a+Qg16FYxkhDY2aWpJ7BHjiy2UGuq82QzN4/Fq+ujEiQ
         kcB0vw1x4qKeag5/RHYw/m5DUHasIlng7+pa2m0vudcw5DRzLvtXIem9Umge0qj4m0og
         tadmAp+3ETpIMt87RsjDdW0DuHd9FIXZSfVwcavoNQe3U6UqmIOsf6gjdhrft5kuCEci
         LQdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778510071; x=1779114871; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+v2ay7d5zaezO4LQdeMSaE6xJKDm17at2Vx/sGq20mw=;
        b=Q5acmmuw9wc8edoPdpXTRIwB3HzpMyeIudW0Ur6smFGRtCXex9lcXNCJEHQ9eBisC2
         OJJsjyxxJeZZLTIHkqIubFD4yul2mCa/jdspskTZwxE3mNC8jZF55CIljIjFjw+66PPX
         ufBLOrpjF2XrNpVGeRVJbp0B4y77uheUB5MKkxLRKdocVLcNMtXXLaygFrzdEM1fetxo
         MJlfxKGffvb52b+X4RGpE8lthQex+Ey0+MEkXvCYQ+jbh0iZd/LB2qZJeggAjsnxPfVe
         0ebDK35wE6quPfMgapxEILmsQTJC90ebkQoQTC/7wq8aY2dccrymOJXQe9egPFlTuuZv
         hUjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778510071; x=1779114871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+v2ay7d5zaezO4LQdeMSaE6xJKDm17at2Vx/sGq20mw=;
        b=E5+SQG1hgPyvj67a/NBiIKjgziu02O4boEK1DdpV+R7SU3PWBnurmRLFmVTJNJ2iNb
         kxUZF1ywOXu3DfDmbHf95IUgrgvDuTSvFqbl/CiXT6zFsjBGaWD3aPi0SRESNvaB2wdr
         HMiC4MT8hSq/D6H9cNP3gS0IBHonOZ8ftDnfeREDEZOnYEzQhtc7EizFjBeUm9kW5Ndf
         qdFlIJhW/lNKnLhej5Gj5IwyRWYIYD8GvqzlisSf5ATd4M7lXZpt7KF5f4cfEAAIgPUz
         yaT9zkP+3qSa/wR0IIAGXzeZN0Pvnc+B6VOBMJh/+tlnw/d9f64uNPGNuPZSE0al0cwa
         C8sg==
X-Forwarded-Encrypted: i=1; AFNElJ9S6yfZA8GJHvbYPFWjTvvOZszaHa5WvGvLeih1D2SmZiUUt6KvQ2m9fiXkLGBXg6fnj023tpOgESY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5b9Wj91PGYyQgoW97VVHLGlhJOnkq4vEmUNK7VumDC5T3nq8V
	1ha8ye3SE3nZcWr70b1WZPYUP0XzRTICfEdCF4uAYEVuwptyAyltUPuJPke3qOD/pY7SADaeRfZ
	EnEKTPh3vLC2slfeP8tByZ5IjsUeLj4HAnn0rhVVUTA==
X-Gm-Gg: Acq92OE/HCQ3ZIWVek/VnRTnfLwSX/qvnxeWwMQE396jHJd6U6tSTO1YKW75UjDtElc
	Nt+m8pyUdvbcMZvtM8rJB2Dpp9YmBK39CWpmtpuJaBRPObiRf8Grx4i6RZLV1DlS+4n3qFCINDR
	AEI2auIV3mDqm1W3hwyrTurPGd0MowhMSri2JOxplxs8WorHLWsafFZ0kLvoy+zPonnhuSnkpmR
	3u8n9CaaW/5vBksqWNIl6giPt6fvmpK0pFXWLkIvp48JLk+dc95w3IkrZenQnYU2Ug3ZGQKLEAE
	RfrRZWthG7MzydcGfX0=
X-Received: by 2002:a05:690c:dd3:b0:7ba:d5fb:b543 with SMTP id
 00721157ae682-7bdf5dcc7b4mr242694677b3.13.1778510070862; Mon, 11 May 2026
 07:34:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1776429984.git.u.kleine-koenig@baylibre.com> <c830049dcfcd99f005e2ff6742aace9341c61f13.1776429984.git.u.kleine-koenig@baylibre.com>
In-Reply-To: <c830049dcfcd99f005e2ff6742aace9341c61f13.1776429984.git.u.kleine-koenig@baylibre.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 11 May 2026 16:33:52 +0200
X-Gm-Features: AVHnY4Lsmc0xOoSZAdNPsitAF34xmre0WH2Fz_Ejkt7Ep8UMQ1cwv9JaIHq62oo
Message-ID: <CAPDyKFo6nvBCnOHXUSvedaT3Rnob+oF=nZoRoic_EkgFBTxzwg@mail.gmail.com>
Subject: Re: [PATCH v1 1/6] sdio: Add syntactic sugar to store a pointer in sdio_driver_id
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Ulf Hansson <ulfh@kernel.org>, 
	"Christian A. Ehrhardt" <christian.ehrhardt@codasip.com>, linux-mmc@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-kernel@vger.kernel.org, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	linux-mediatek@lists.infradead.org, Ping-Ke Shih <pkshih@realtek.com>, 
	linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, 
	Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
	Brian Norris <briannorris@chromium.org>, Francesco Dolcini <francesco@dolcini.it>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 17 Apr 2026 at 15:11, Uwe Kleine-K=C3=B6nig (The Capable Hub)
<u.kleine-koenig@baylibre.com> wrote:
>
> On all current Linux architectures sizeof(long) =3D=3D sizeof(void *) and
> this is used a lot through the kernel. For example it enables the usual
> practice to store pointers in sdio_driver_id's .driver_data member.
>
> This works fine, but involves casting and thus isn't type-safe.
> Additionally with the CHERI architecture extension there are machines
> with sizeof(void *) > sizeof(long) for with the traditional approach of
> storing a pointer in .driver_data doesn't work.
>
> By replacing the plain unsigned long .driver_data by an anonymous union,
> most of the casting can be dropped and it yields a working solution for
> CHERI.
>
> All users of struct sdio_driver_id are initialized in a way that is
> compatible with the new definition, so no adaptions are needed there.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@b=
aylibre.com>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Feel free to take this via whatever tree makes best sense!

Kind regards
Uffe

> ---
>  include/linux/mod_devicetable.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_deviceta=
ble.h
> index 5b1725fe9707..0eb5d196f5b5 100644
> --- a/include/linux/mod_devicetable.h
> +++ b/include/linux/mod_devicetable.h
> @@ -414,7 +414,10 @@ struct sdio_device_id {
>         __u8    class;                  /* Standard interface or SDIO_ANY=
_ID */
>         __u16   vendor;                 /* Vendor or SDIO_ANY_ID */
>         __u16   device;                 /* Device ID or SDIO_ANY_ID */
> -       kernel_ulong_t driver_data;     /* Data private to the driver */
> +       union {                         /* Data private to the driver */
> +               kernel_ulong_t driver_data;
> +               const void *driver_data_ptr;
> +       };
>  };
>
>  /* SSB core, see drivers/ssb/ */
> --
> 2.47.3
>

Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DD33D566A
	for <linux-mmc@vger.kernel.org>; Fri,  4 Sep 2026 08:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788508863; cv=none; b=q38Bft2Z5pM98jmajsgmtsWwaNw45YpKidH8D490e7X3MBufg4+OF8H72GhJ9x0fPrTeubeyfN69Pua0TLorGcMIiRlGaE2frpC3FCy/iP5T5B96zIVBDisdw1Abehf+uiarU7AuA5bVmZnAfR3doHb5oQhwcpSdzFrV1In+pkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788508863; c=relaxed/simple;
	bh=5STgmEpuSXLAENtQSqsuFnM5l/nP8haJUcsvw0rzQek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=khgOaqHstVWjwkSDb5wXm4gpIqlSZM8kJdwua1cAZulMubF7tZtprQdJsqwDPd6I96v1ia0zWNG69fd3xgE5F3YG+3Kn8rbYB+IPMxZjFKRilLeYy4/9H8p3P4lgsXuLUKmY0dwiaMDff8haVTcCBhtQIexAmoXC4ilCDRSMXFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5c5f23666d0so694394e0c.3
        for <linux-mmc@vger.kernel.org>; Fri, 04 Sep 2026 01:01:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788508860; x=1789113660;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DHcVzyvg5T1LbBIIYfTsEAB71A8C4BjQEyDgYTrzH78=;
        b=kRPjlFkbSvbTP0vRc5pxKmiyW45r7UXCw7dPRTChNogQNgmgJ6IvQEJ5DJGdVbkvQL
         kDzueWxEKxxhKObvM2eTf9Dfz+O95hDbEq9zT548x/oqAgUsHXFINUeCyk7xCt1TZmZ1
         AGGP4UOLyTqqoUIJ0QSyDJcMoqfUET+47WT/XmL6r/09lHc+T0fVaBshV9u8tOaC3DvZ
         SxEe4+Ec1Glk0BDlVUxypcznMOUUo4wxQfMHPMQVBhoS/ZGsjNxno7seH1K61lVqRUPc
         gN4VqI/odFZE2lo3C/Fl/er9t4oahH5k8gPaImWEAX+bKMfwFwelRBtyv8dFVeTkFaVH
         ftzQ==
X-Forwarded-Encrypted: i=1; AKwUvByCXOunp/oacGgs1Xh6rBevWe06UNjjXrrfEub+vrYTE2LmAK5AlfvBYu7Zk76TbY2b0Y9DtVmFsY0=@vger.kernel.org
X-Gm-Message-State: AFuF++mMhK90D/hwWPNkyUkZ301yc5GvAhRcuFYag72YR9JOniYxDISg
	Zv6yJ++GP5uHz7vIAl3SZOb8B5FQcpiaM23CTZyz0sls7kH5zktGXJkABkNP+nc5xy0=
X-Gm-Gg: AYBFou1JIVYeGanK9v6OeMZvuVIEPbLdETAEWc/JpNIj5GVmfa7M9QJGZttr7STVxWY
	ON2oCN/nmZXBV72BNZz0E+C3AVOhKRFboZisSusKJRfYItNHik00xmb4KmNkAnO7s07HRHAi39z
	0rU+/XTPTazSOmN84LpLCz8ACMa2x+G7y0aps3mEp8G/9s7o8Py5zDs9tuQ4S0XUyBtfXH9sEsU
	Q/QdmLdiT9WfwDMrjX5PyUgxYuhVmHrp4ljDDPfBLDqd+vBDu3AY6lvcdNf6WL2h+BD6r6eVjCJ
	ZtXTfiIbGSDw2LN5n6T4OgRBMj+qYPbfi9dTkMzEBzsaBVPAYqeZAbh2byaXW1lFS6ZS/scRvU+
	ObXk5rwEwVTDOm1S+o0eA6GSq+BSzITa/lJoe6q/64/apR4EX9Azs/sl6toOLKa7eRsx7rxppyH
	nJ8FXdMGMQSij0+gjMIcf6p3S83e5L741Cg/G+Ilj4ranr2KqUoEpF0mv/xeDlbFOzTAfLjH/6x
	vpl+voQu6AFAzE7my4Ev3/aOxyBLu2gYKWL
X-Received: by 2002:a05:6122:2205:b0:5c7:ebed:1018 with SMTP id 71dfb90a1353d-5c7ed7f9e30mr1858102e0c.8.1788508860645;
        Fri, 04 Sep 2026 01:01:00 -0700 (PDT)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c7ebf559cbsm1650684e0c.0.2026.09.04.01.01.00
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 01:01:00 -0700 (PDT)
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-7542a2ee156so435753137.0
        for <linux-mmc@vger.kernel.org>; Fri, 04 Sep 2026 01:01:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByOQBHe2uSO4g2H5FrXLxo6Rr/qxva1PP318lcgR23n8Y5UVki9j0VcLtMiIKOBDBsZJ08eKfvgs40=@vger.kernel.org
X-Received: by 2002:a05:6102:e0d:b0:778:5bbb:b2d2 with SMTP id
 ada2fe7eead31-78a4a97bda0mr1434786137.11.1788508859808; Fri, 04 Sep 2026
 01:00:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820171657.62815-1-biju.das.jz@bp.renesas.com> <apnUfCIcTG4bmYZF@ninjato>
In-Reply-To: <apnUfCIcTG4bmYZF@ninjato>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 4 Sep 2026 10:00:48 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVOY2CYKfhmx4qmRPkf3a002NEbWuwafLvrJTXvLb9PLA@mail.gmail.com>
X-Gm-Features: AcwNN1URdf1eUYUIsC6Dx67B7nRZjxmnJO7wd9vXW0tYWJ8jFblIIeeoKCEUiQM
Message-ID: <CAMuHMdVOY2CYKfhmx4qmRPkf3a002NEbWuwafLvrJTXvLb9PLA@mail.gmail.com>
Subject: Re: [PATCH v24 00/15] Add Renesas RZ/G3L SD/eMMC support
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Biju <biju.das.au@gmail.com>, Ulf Hansson <ulfh@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Magnus Damm <magnus.damm@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 3 Sept 2026 at 22:11, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> Although there are still issues to be handled, I tested this series on a
> R-Car S4 (Spider) with HS400 eMMC and on a R-Car V4H (SparrowHawk) with
> a UHS SD card. No regressions.

FTR, boot-tested on a wide range of Renesas platforms (RZ/A1H, RZ/A2M,
R-Mobile A1, SH-Mobile AG5, R-Car Gen1-4, RZ/Five)
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

From: Chris Moore <moore@free.fr>
Subject: Re: [PATCH v2 1/4] mmc: meson-gx: use bitfield macros
Date: Sat, 25 Mar 2017 15:16:11 +0100
Message-ID: <22cd1b77-41b7-3283-f184-5bb916bdb52f@free.fr>
References: <aae9e7c7-d8a2-72b1-22f7-f0ad513d4667@gmail.com>
 <ed2aa5cb-4cac-11b6-1be4-5d0e42001c45@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp4-g21.free.fr ([212.27.42.4]:50868 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750903AbdCYOQS (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sat, 25 Mar 2017 10:16:18 -0400
In-Reply-To: <ed2aa5cb-4cac-11b6-1be4-5d0e42001c45@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>
Cc: linux-amlogic@lists.infradead.org, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi,

Le 25/03/2017 à 11:23, Heiner Kallweit a écrit :
> Use GENMASK consistently for all bit masks and switch to using the
> bitfield macros GET_FIELD and PREP_FIELD. This hides parts of the

Nitpick:
s/GET_FIELD/FIELD_GET
s/PREP_FIELD/FIELD_PREP

> complexity of dealing with bit fields.

Chris

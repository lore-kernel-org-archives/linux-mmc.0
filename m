From: Johan Rudholm <jrudholm@gmail.com>
Subject: Re: [RFC] mmc: sdhci: Let core handle UHS switch failure
Date: Fri, 28 Sep 2012 17:10:41 +0200
Message-ID: <CA+20K0BiZNrLkD44UdEKKSyrZvHZEYX9C47ndB8Q3bvJ+Gk8hQ@mail.gmail.com>
References: <1348817743-1391-1-git-send-email-johan.rudholm@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:58351 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758490Ab2I1PKm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 28 Sep 2012 11:10:42 -0400
Received: by ieak13 with SMTP id k13so7542555iea.19
        for <linux-mmc@vger.kernel.org>; Fri, 28 Sep 2012 08:10:41 -0700 (PDT)
In-Reply-To: <1348817743-1391-1-git-send-email-johan.rudholm@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Johan Rudholm <johan.rudholm@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Per Forlin <per.forlin@stericsson.com>, Ulf Hansson <ulf.hansson@linaro.org>, Fredrik Soderstedt <fredrik.soderstedt@stericsson.com>, Kevin Liu <keyuan.liu@gmail.com>, Philip Rakity <prakity@marvell.com>

Hi,

sorry, spotted one snafu:

2012/9/28 Johan Rudholm <johan.rudholm@stericsson.com>:
>
> +static void sdhci_card_busy(struct mmc_host *mmc, bool keep_busy)

should be

static int sdhci_card_busy(struct mmc_host *mmc, int keep_busy)

Kind regards, Johan

From: Anton Vorontsov <avorontsov@mvista.com>
Subject: [PATCH 0/3] Add support for CNS3xxx SDHCI hosts
Date: Fri, 25 Jun 2010 22:05:27 +0400
Message-ID: <20100625180527.GA11280@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Ben Dooks <ben@simtec.co.uk>, Richard =?utf-8?Q?R=C3=B6jfors?= <richard.rojfors@pelagicore.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi all,

Ben Dooks once suggested that we'd better keep SDHCI SoC-specific
stuff in the driver/mmc/, as it's done for SDHCI S3C, eSDHC and
HLWD devices. This helps maintain the code, and keeps MMC-specific
stuff out of the platform code.

We already do this for OpenFirmware platforms (see sdhci-of-*),
but the infrastructure isn't ready for the platform devices.

This patch set adds CNS3xxx SoC support. But to not duplicate the
sdhci-pltfm code, it converts the driver to module device table
matching, and then just adds CNS3xxx-specific driver_data.

Further more, as OF and Platform buses are going to be merged
soon, this patch set also helps the transition.

Plus, if anybody is willing, sdhci-s3c can be merged into
sdhci-pltfm (need to implement struct clk handling for this).

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2

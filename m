From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 0/4] mmc: sdhci-s3c: use the sdhci-pltfm.c and move
 the header file
Date: Tue, 6 Mar 2012 13:00:54 +0000
Message-ID: <20120306130054.GA9890@sirena.org.uk>
References: <4F55ABF0.1060801@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4F55ABF0.1060801@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, linux-samsung-soc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, 'kgene kim' <kgene.kim@samsung.com>
List-Id: linux-mmc@vger.kernel.org

On Tue, Mar 06, 2012 at 03:17:20PM +0900, Jaehoon Chung wrote:
> This patchset is the purpose for using sdhci-pltfm.c and 
> removing the arch dependency.
> The sdhci-s3c has too heavy arch dependency.
> For example, if work for sdhci-s3c.c at mmc-tree, sometime need to change sdhci.h for Samsung-Soc.

This series will break S3C64xx, you've not touched it at all in the
update but it uses the same SDHCI controller.

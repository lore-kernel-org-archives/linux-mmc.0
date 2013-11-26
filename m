From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: 3.13-rc1: MMC & fixed regulator regression
Date: Tue, 26 Nov 2013 20:03:26 +0200
Message-ID: <20131126180325.GF24645@blackmetal.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, Laxman Dewangan <ldewangan@nvidia.com>, Mark Brown <broonie@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi,

On N950 with fixed vmmc regulator, MMC probe started to fail with
3.13-rc1:

[    2.497406] mmc0: host doesn't support card's voltages
[    2.502899] mmc0: error -22 whilst initialising MMC card

I bisected this to c368e5fc2a190923b786f2de3e79430ea3566a25
(regulator: fixed: get rid of {get|list}_voltage()). With this commit
regulator_list_voltage() does not work anymore for a fixed regulator. MMC
code is using this in mmc_regulator_get_ocrmask().

A.

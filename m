From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH v3 10/14] mmc: jz4740: Let the pinctrl driver configure
 the pins
Date: Thu, 26 Jan 2017 14:11:53 +0800
Message-ID: <201701261459.cfXHvGfn%fengguang.wu@intel.com>
References: <20170125185207.23902-11-paul@crapouillou.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="r5Pyd7+fXNt84Ff3"
Return-path: <linux-pwm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170125185207.23902-11-paul@crapouillou.net>
Sender: linux-pwm-owner@vger.kernel.org
Cc: kbuild-all@01.org, Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ralf Baechle <ralf@linux-mips.org>, Ulf Hansson <ulf.hansson@linaro.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, Thierry Reding <thierry.reding@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Maarten ter Huurne <maarten@treewalker.org>, Lars-Peter Clausen <lars@metafoo.de>, Paul Burton <paul.burton@imgtec.com>, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, james.hogan@imgtec.com, Paul Cercueil <paul@crapouillou.net>
List-Id: linux-mmc@vger.kernel.org


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Paul,

[auto build test ERROR on linus/master]
[also build test ERROR on v4.10-rc5 next-20170125]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Paul-Cercueil/Ingenic-JZ4740-JZ4780-pinctrl-driver/20170126-030028
config: mips-qi_lb60_defconfig (attached as .config)
compiler: mipsel-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=mips 

All errors (new ones prefixed by >>):

   drivers/mmc/host/jz4740_mmc.c: In function 'jz4740_mmc_set_ios':
>> drivers/mmc/host/jz4740_mmc.c:864:7: error: implicit declaration of function 'gpio_is_valid' [-Werror=implicit-function-declaration]
      if (gpio_is_valid(host->pdata->gpio_power))
          ^~~~~~~~~~~~~
>> drivers/mmc/host/jz4740_mmc.c:865:4: error: implicit declaration of function 'gpio_set_value' [-Werror=implicit-function-declaration]
       gpio_set_value(host->pdata->gpio_power,
       ^~~~~~~~~~~~~~
   drivers/mmc/host/jz4740_mmc.c: In function 'jz4740_mmc_request_gpio':
>> drivers/mmc/host/jz4740_mmc.c:916:8: error: implicit declaration of function 'gpio_request' [-Werror=implicit-function-declaration]
     ret = gpio_request(gpio, name);
           ^~~~~~~~~~~~
>> drivers/mmc/host/jz4740_mmc.c:923:3: error: implicit declaration of function 'gpio_direction_output' [-Werror=implicit-function-declaration]
      gpio_direction_output(gpio, value);
      ^~~~~~~~~~~~~~~~~~~~~
>> drivers/mmc/host/jz4740_mmc.c:925:3: error: implicit declaration of function 'gpio_direction_input' [-Werror=implicit-function-declaration]
      gpio_direction_input(gpio);
      ^~~~~~~~~~~~~~~~~~~~
   drivers/mmc/host/jz4740_mmc.c: In function 'jz4740_mmc_free_gpios':
>> drivers/mmc/host/jz4740_mmc.c:968:3: error: implicit declaration of function 'gpio_free' [-Werror=implicit-function-declaration]
      gpio_free(pdata->gpio_power);
      ^~~~~~~~~
   cc1: some warnings being treated as errors

vim +/gpio_is_valid +864 drivers/mmc/host/jz4740_mmc.c

61bfbdb8 Lars-Peter Clausen 2010-07-15  858  	if (ios->clock)
61bfbdb8 Lars-Peter Clausen 2010-07-15  859  		jz4740_mmc_set_clock_rate(host, ios->clock);
61bfbdb8 Lars-Peter Clausen 2010-07-15  860  
61bfbdb8 Lars-Peter Clausen 2010-07-15  861  	switch (ios->power_mode) {
61bfbdb8 Lars-Peter Clausen 2010-07-15  862  	case MMC_POWER_UP:
61bfbdb8 Lars-Peter Clausen 2010-07-15  863  		jz4740_mmc_reset(host);
61bfbdb8 Lars-Peter Clausen 2010-07-15 @864  		if (gpio_is_valid(host->pdata->gpio_power))
61bfbdb8 Lars-Peter Clausen 2010-07-15 @865  			gpio_set_value(host->pdata->gpio_power,
61bfbdb8 Lars-Peter Clausen 2010-07-15  866  					!host->pdata->power_active_low);
61bfbdb8 Lars-Peter Clausen 2010-07-15  867  		host->cmdat |= JZ_MMC_CMDAT_INIT;
fca9661c Lars-Peter Clausen 2013-05-12  868  		clk_prepare_enable(host->clk);
61bfbdb8 Lars-Peter Clausen 2010-07-15  869  		break;
61bfbdb8 Lars-Peter Clausen 2010-07-15  870  	case MMC_POWER_ON:
61bfbdb8 Lars-Peter Clausen 2010-07-15  871  		break;
61bfbdb8 Lars-Peter Clausen 2010-07-15  872  	default:
61bfbdb8 Lars-Peter Clausen 2010-07-15  873  		if (gpio_is_valid(host->pdata->gpio_power))
61bfbdb8 Lars-Peter Clausen 2010-07-15  874  			gpio_set_value(host->pdata->gpio_power,
61bfbdb8 Lars-Peter Clausen 2010-07-15  875  					host->pdata->power_active_low);
fca9661c Lars-Peter Clausen 2013-05-12  876  		clk_disable_unprepare(host->clk);
61bfbdb8 Lars-Peter Clausen 2010-07-15  877  		break;
61bfbdb8 Lars-Peter Clausen 2010-07-15  878  	}
61bfbdb8 Lars-Peter Clausen 2010-07-15  879  
61bfbdb8 Lars-Peter Clausen 2010-07-15  880  	switch (ios->bus_width) {
61bfbdb8 Lars-Peter Clausen 2010-07-15  881  	case MMC_BUS_WIDTH_1:
61bfbdb8 Lars-Peter Clausen 2010-07-15  882  		host->cmdat &= ~JZ_MMC_CMDAT_BUS_WIDTH_4BIT;
61bfbdb8 Lars-Peter Clausen 2010-07-15  883  		break;
61bfbdb8 Lars-Peter Clausen 2010-07-15  884  	case MMC_BUS_WIDTH_4:
61bfbdb8 Lars-Peter Clausen 2010-07-15  885  		host->cmdat |= JZ_MMC_CMDAT_BUS_WIDTH_4BIT;
61bfbdb8 Lars-Peter Clausen 2010-07-15  886  		break;
61bfbdb8 Lars-Peter Clausen 2010-07-15  887  	default:
61bfbdb8 Lars-Peter Clausen 2010-07-15  888  		break;
61bfbdb8 Lars-Peter Clausen 2010-07-15  889  	}
61bfbdb8 Lars-Peter Clausen 2010-07-15  890  }
61bfbdb8 Lars-Peter Clausen 2010-07-15  891  
61bfbdb8 Lars-Peter Clausen 2010-07-15  892  static void jz4740_mmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
61bfbdb8 Lars-Peter Clausen 2010-07-15  893  {
61bfbdb8 Lars-Peter Clausen 2010-07-15  894  	struct jz4740_mmc_host *host = mmc_priv(mmc);
61bfbdb8 Lars-Peter Clausen 2010-07-15  895  	jz4740_mmc_set_irq_enabled(host, JZ_MMC_IRQ_SDIO, enable);
61bfbdb8 Lars-Peter Clausen 2010-07-15  896  }
61bfbdb8 Lars-Peter Clausen 2010-07-15  897  
61bfbdb8 Lars-Peter Clausen 2010-07-15  898  static const struct mmc_host_ops jz4740_mmc_ops = {
61bfbdb8 Lars-Peter Clausen 2010-07-15  899  	.request	= jz4740_mmc_request,
bb2f4592 Apelete Seketeli   2014-07-21  900  	.pre_req	= jz4740_mmc_pre_request,
bb2f4592 Apelete Seketeli   2014-07-21  901  	.post_req	= jz4740_mmc_post_request,
61bfbdb8 Lars-Peter Clausen 2010-07-15  902  	.set_ios	= jz4740_mmc_set_ios,
58e300af Lars-Peter Clausen 2013-06-09  903  	.get_ro		= mmc_gpio_get_ro,
58e300af Lars-Peter Clausen 2013-06-09  904  	.get_cd		= mmc_gpio_get_cd,
61bfbdb8 Lars-Peter Clausen 2010-07-15  905  	.enable_sdio_irq = jz4740_mmc_enable_sdio_irq,
61bfbdb8 Lars-Peter Clausen 2010-07-15  906  };
61bfbdb8 Lars-Peter Clausen 2010-07-15  907  
c3be1efd Bill Pemberton     2012-11-19  908  static int jz4740_mmc_request_gpio(struct device *dev, int gpio,
61bfbdb8 Lars-Peter Clausen 2010-07-15  909  	const char *name, bool output, int value)
61bfbdb8 Lars-Peter Clausen 2010-07-15  910  {
61bfbdb8 Lars-Peter Clausen 2010-07-15  911  	int ret;
61bfbdb8 Lars-Peter Clausen 2010-07-15  912  
61bfbdb8 Lars-Peter Clausen 2010-07-15  913  	if (!gpio_is_valid(gpio))
61bfbdb8 Lars-Peter Clausen 2010-07-15  914  		return 0;
61bfbdb8 Lars-Peter Clausen 2010-07-15  915  
61bfbdb8 Lars-Peter Clausen 2010-07-15 @916  	ret = gpio_request(gpio, name);
61bfbdb8 Lars-Peter Clausen 2010-07-15  917  	if (ret) {
61bfbdb8 Lars-Peter Clausen 2010-07-15  918  		dev_err(dev, "Failed to request %s gpio: %d\n", name, ret);
61bfbdb8 Lars-Peter Clausen 2010-07-15  919  		return ret;
61bfbdb8 Lars-Peter Clausen 2010-07-15  920  	}
61bfbdb8 Lars-Peter Clausen 2010-07-15  921  
61bfbdb8 Lars-Peter Clausen 2010-07-15  922  	if (output)
61bfbdb8 Lars-Peter Clausen 2010-07-15 @923  		gpio_direction_output(gpio, value);
61bfbdb8 Lars-Peter Clausen 2010-07-15  924  	else
61bfbdb8 Lars-Peter Clausen 2010-07-15 @925  		gpio_direction_input(gpio);
61bfbdb8 Lars-Peter Clausen 2010-07-15  926  
61bfbdb8 Lars-Peter Clausen 2010-07-15  927  	return 0;
61bfbdb8 Lars-Peter Clausen 2010-07-15  928  }
61bfbdb8 Lars-Peter Clausen 2010-07-15  929  
58e300af Lars-Peter Clausen 2013-06-09  930  static int jz4740_mmc_request_gpios(struct mmc_host *mmc,
58e300af Lars-Peter Clausen 2013-06-09  931  	struct platform_device *pdev)
61bfbdb8 Lars-Peter Clausen 2010-07-15  932  {
61bfbdb8 Lars-Peter Clausen 2010-07-15  933  	struct jz4740_mmc_platform_data *pdata = pdev->dev.platform_data;
58e300af Lars-Peter Clausen 2013-06-09  934  	int ret = 0;
61bfbdb8 Lars-Peter Clausen 2010-07-15  935  
61bfbdb8 Lars-Peter Clausen 2010-07-15  936  	if (!pdata)
61bfbdb8 Lars-Peter Clausen 2010-07-15  937  		return 0;
61bfbdb8 Lars-Peter Clausen 2010-07-15  938  
58e300af Lars-Peter Clausen 2013-06-09  939  	if (!pdata->card_detect_active_low)
58e300af Lars-Peter Clausen 2013-06-09  940  		mmc->caps2 |= MMC_CAP2_CD_ACTIVE_HIGH;
58e300af Lars-Peter Clausen 2013-06-09  941  	if (!pdata->read_only_active_low)
58e300af Lars-Peter Clausen 2013-06-09  942  		mmc->caps2 |= MMC_CAP2_RO_ACTIVE_HIGH;
61bfbdb8 Lars-Peter Clausen 2010-07-15  943  
58e300af Lars-Peter Clausen 2013-06-09  944  	if (gpio_is_valid(pdata->gpio_card_detect)) {
214fc309 Laurent Pinchart   2013-08-08  945  		ret = mmc_gpio_request_cd(mmc, pdata->gpio_card_detect, 0);
61bfbdb8 Lars-Peter Clausen 2010-07-15  946  		if (ret)
61bfbdb8 Lars-Peter Clausen 2010-07-15  947  			return ret;
61bfbdb8 Lars-Peter Clausen 2010-07-15  948  	}
61bfbdb8 Lars-Peter Clausen 2010-07-15  949  
58e300af Lars-Peter Clausen 2013-06-09  950  	if (gpio_is_valid(pdata->gpio_read_only)) {
58e300af Lars-Peter Clausen 2013-06-09  951  		ret = mmc_gpio_request_ro(mmc, pdata->gpio_read_only);
58e300af Lars-Peter Clausen 2013-06-09  952  		if (ret)
58e300af Lars-Peter Clausen 2013-06-09  953  			return ret;
61bfbdb8 Lars-Peter Clausen 2010-07-15  954  	}
61bfbdb8 Lars-Peter Clausen 2010-07-15  955  
58e300af Lars-Peter Clausen 2013-06-09  956  	return jz4740_mmc_request_gpio(&pdev->dev, pdata->gpio_power,
58e300af Lars-Peter Clausen 2013-06-09  957  			"MMC read only", true, pdata->power_active_low);
61bfbdb8 Lars-Peter Clausen 2010-07-15  958  }
61bfbdb8 Lars-Peter Clausen 2010-07-15  959  
61bfbdb8 Lars-Peter Clausen 2010-07-15  960  static void jz4740_mmc_free_gpios(struct platform_device *pdev)
61bfbdb8 Lars-Peter Clausen 2010-07-15  961  {
61bfbdb8 Lars-Peter Clausen 2010-07-15  962  	struct jz4740_mmc_platform_data *pdata = pdev->dev.platform_data;
61bfbdb8 Lars-Peter Clausen 2010-07-15  963  
61bfbdb8 Lars-Peter Clausen 2010-07-15  964  	if (!pdata)
61bfbdb8 Lars-Peter Clausen 2010-07-15  965  		return;
61bfbdb8 Lars-Peter Clausen 2010-07-15  966  
61bfbdb8 Lars-Peter Clausen 2010-07-15  967  	if (gpio_is_valid(pdata->gpio_power))
61bfbdb8 Lars-Peter Clausen 2010-07-15 @968  		gpio_free(pdata->gpio_power);
61bfbdb8 Lars-Peter Clausen 2010-07-15  969  }
61bfbdb8 Lars-Peter Clausen 2010-07-15  970  
c3be1efd Bill Pemberton     2012-11-19  971  static int jz4740_mmc_probe(struct platform_device* pdev)

:::::: The code at line 864 was first introduced by commit
:::::: 61bfbdb856879cff583fe53b2ab6ae907faedee7 MMC: Add support for the controller on JZ4740 SoCs.

:::::: TO: Lars-Peter Clausen <lars@metafoo.de>
:::::: CC: Ralf Baechle <ralf@linux-mips.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--r5Pyd7+fXNt84Ff3
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICNORiVgAAy5jb25maWcAjFzdcts2sL7vU3DSM2fambax5Z8kc8YXIAhKqEiCAUBZ9g1G
sZVGU1v2SHLTvP3ZBUmRoACpF21s7AJYAIvdbxdL//zTzxF52708L3arh8XT04/or+V6uVns
lo/R19XT8v+iRESF0BFLuP4DmLPV+u3f98+r1210+cf52R9nv28erqLpcrNePkX0Zf119dcb
dF+9rH/6+ScqipSPTc5LdfPjJ2j4OcoXD99W62W0XT4tHxq2n6MeoxmzgklOo9U2Wr/sgHE3
YCAZnbD8zstA5Ad/u56MrkKUD5+8lPikODHNLz/M5yHa9UWAZgemIiaZ9tMJnZiEUaWJ5qII
8/xJ7u/71D6NFyA6p7Dx+z4ZKTT/7B0uI4ocESYTohgrUVyMTvNcX4Z5Sg5rohMuwixznqXl
mIQ3LodtC5DrKWhAyoJRYJFTxgsV7j+Tl+eBcyvmpVE6Ho3OjpP9mlbmML0qvTRJMl5MvSQ1
5oaXI/+SGqJf6RvixyPEwE4pHt9pZqic8IId5SAyZ9mJMcTxMU4yqFuY5RhDxrXOmKrk0VFY
oYXyK07DEvNxcJCCm4AQVmv0/OJT6LbX9MsgnU+l0HxqZHwVOA9KZrzKjaCaicIo4TdHRZab
eSZNLIhMjnCURzjsDSuJhAmlYw8a+p/3lx8uz8xnbrL4+qxvXJDy8cxQ7t4Ox1zZztCp1fpb
xfLWwhpV8iITdNoflEjoNiHK8EyMR6YK7M+QzTVBDVM7z+SW8fFEd2K0BAqXMJYEFCFhGbnr
GBQ4nMSInGuTSpIzUwpeaCb7ktY2HeU3M3WnYCz/tbCiJjkxJEmk0eb6Mua+jbZ8qipLIbUy
VSlFzFQnEo5QiIKKCZOg2B2hYCAqUnOC1ghWcyAlnkXoXhfCcIFzYn+PWLSsmutmWJFwUvR2
6U51Ag95XAkm1ZgZncUtv09hkC87h0OBzTdqwlN9c1VjCJDBwQ890bDXxcjI84BY97EQ+hjN
VETq8+urqzOXC5UrMEHXfNgWFORiBMdupkwWLHO7nWCZwM0Fe8jMLdF0YhVxD64aGLb78brs
tsUO0z+B6QzuXMWUb9dLAgej+D0zl9O436kjnF9PY79/27NcX7osDUMqJGWgV3NzDxZfyARu
0Pl5f+24y6VkKYOlubvS3tGkykvUHJcqL6cmLavDxlp7DvjxkijUdQV4QFtVExIOjErRgNWB
UOquoF1rDUMVTxq9PDskwJ6rm4/ec52A9clZ3g1nr3qaEQ2tcGNInLGO2LS7DSB6AjsJ7HBL
+7oxs61xY0Z9zU3XfrfaJHGwWTLpd9+frB0AbwfOyItU2EE8J6xKuPem1HYiWLS6uew5MZGX
hAYBbTmB+3HCKKJTMlqYuFKORqvcw5ywlFQZGDK0hDkv7OA3l2efrh1bWTJpz2ea94ekGSOF
1R6vsKkUcO9uiR/N0dwPM+5LIfxe4T6u/P74HjQ0ywIOnydgYu2105LQKSB+L9vk3oz8mBwo
lx89Wwft52eOd8eWAJLE4a/8iNiSrkMkmCLY7fxs5PPhjg0lEg3k5L6n6fc3MGgPtVnHPZGa
Uz+4BmPD8hLvU8AftgwzkVWFJvLOZzRrnk6MthMVVeGaXjZn/qOkkqiJtW5++MkoXp8wZBPg
lNLy+vKIR60UMyLtpIwrnmm4FomOB6YNDCMpS/DdCCW04wcsnWWpwxAWS5Lb/8hJ8wRCIIY3
K/9vnMBk2FzD2CH44IyJ9isTJLGwrY16wU4lrGw3reerIUqd4qVihzRrDcEIs4LeaeHpXI41
2nCTsRnL1M2oZ5DaeSEMvnn3/mn15f3zy+Pb03L7/n+qApGlZGB4FHv/x4PNpbxr+3L52dwK
OXWPL9Ec+sAm2PlULYWFAmObxnnCLXl77cBALMWUFQaDiLznAXgBF4kVM7hSKBwA3ZuLvdjg
FJWy1puDY3r3zrXo0Ga0H0zA7pJsxqQCk+/06xMMqbTwmSDc5Rr8mPE9H3q5hhIDZeQnZfc5
8VPm96EeIkS47AiuTL2r3Qnk1d2eWMfo8/vjvf2Zk07QI45wIpRGJbt598v6Zb38da9c6Mgc
nDrjJT1owH+pzhxUKBSfm/xzxSq/+ax1B2CDkHeGaMz9+IDhhBRJ5gQqYKwgGPNHUFXiggOr
8HBBou3bl+2P7W753Cl8ixvx/tgY6jDsQ5KaiFs/BUKl/kWBlkTkhBd9TUHhm2bk6K+j6wDH
EFdjz+qRxULjxOiJZCQBPz4AZzauVKJC/JwQTQ5FtYagDTw9oS0OAOaoDhaGxFxghJnUsaLd
Tb16Xm62vg0F3wyIiYvETS2CywAKApJQWDnxKzaiYbB6yq5AqoNzBWj2Xi+2f0c7EClarB+j
7W6x20aLh4eXt/Vutf6rkw3dvMVyhFrXW2/kfiqLHl0y7oEfWsGh2D3teP1pXpWgXlEGag6s
/hSqJmqKofjh6iStInW4yS2AAHJ/AfArGHvYfp+1VQNmOyl28fDiQCBQlqEJz4UToGuY2zJY
9+fPVjZywD2s4wL/1qCDgkCoGAXQ67T+wes5sHvahFfnl3vAnvMh7WKozTXmo8MYho6lqEp/
3hd60KkNpVETtZABJQbbqSCEYf5R6onRndmp/Dx3KlVgCeCAKVw3P+aXmH3yb2k2hc4z66+l
D/ZQakQJeotRONgUvKrwTw6hjGNdh2wYtfvRdm3wW1sEMBnmhthPOd4BmEAfKCsxuKv1podT
yh7mrLW3BzfBL3Gw9T1MpsZM56C75sCY1Zvna0YBDtpr51SblZ77Bh51l3taTN2786n79lgB
+gdVB9kx93S4UXvWGLCbPT/NZ709KCXo1nT4O6pzH8/1rD4ibAp62CPjyGnVX2AKMs17fUrh
bAsfFyRLk67FbkW/wToE29BpWJkaT/qyHXOQuOA9wESSGQcRm85OfI4HbCFI6oXqLI+JlLyv
BNDEEogZBngM1dkM3ZhtxOBmVofKg2xYudx8fdk8L9YPy4j9s1yD7yDgRSh6D/Bx/ffH3vDe
6zfLa2od2A28lZvn0AC1p74dzIgTT6ms8qMclYkQgcQQ0TCGQQQEWAXAi5Ct0Sy3eMEA2OYp
p+HnRPBhKc8GXq6/9aLmcMzItM5Kewf8ExN1IGrgdag60tXOZ1NAcCVBi9GqUvSwoTQ5Hn4b
zcYumK1h/DB7XrdKpr0E51raFjuLtWsTIYaZNUy2w++ajytReeAVRFp1pqZGd4Peko3BwhRJ
HXI2C4WYeSgCzXzzAl+NK30Cd0cwgJO3BHQYEX1JJN6bJkTzDNHkHQycvO7fz1okWgsNm6gZ
Bbc5cDEu0e+tXB6bhzk6Cu5XlRH/I90ht9JShHUaTw2C5332bLC+AF4ccHmQ4jD1KpJmN0tG
8Rr2/J9IqgzAL2ow2nx5cFaYfbYUe9HBTw8GZ3O4JnvNcu9QO8DEj78UwUQq6pDvbDI4CvA6
dHpLZOKYc5tBF4alsBSO5jBNj1xkK8SseY1y03B1poKK2e9fFtvlY/R3bbFfNy9fV081st+P
hWxNmHv8CdAyNsbK+N2YlWv/omCv7/AZDa0sZrq7FnwSQ4fbNxfWKdsMbe8NoD5SJ2lmm5r3
D8xB+bxgzVMVSA92rsn+3JhImoscKG6ox4EwYZ95CTxRtpzcH/I0ZLQLcmCUe0EEz0FYUOvE
TBEZeVY8eKXI4oSkDhRpwG6sAqFXRw+lCjq8rNlYcn0cVeOrlH9vkaNNJlqb6bc/yHYbH+Ym
ysVmt8LHykj/eF1ue3EekZpb0AzoCUG6c/IEEGDR8fjVHiDucQ6h0lNj5HxMTvFoIvkJnpxQ
P0dLV4lQHYdz1hBGJ1xNw4Ahh5hnblQVH5cBkDoIqsz84/UJaSsYzz6kHp83S/ITA2ElzYmp
MrgPp85JVafOekogkjvBw9JTwmA27/rjCaaesh9y1fk2EamHb0tMXm96Gs1FHQYXQvTTZk1r
Al4Kx3UyZA2Npp89OtPmLn09WxrOdaRrM8HNu8fl4hHcynKf9wQVKOwysfTE2ta+QUKMfW9B
j11w/LaNXl7xFm+jX0rKf4tKmlNOfosYeNLfIvs/TX/t3W4K4ExyNLcmY2NCeyUlee4ka0pK
BxU5dk727/Lhbbf48rS01ZiRDWR2ve1GH5VrBAgD2NAR9kUgXWjZRJa9iAWvAaLFds+w34Th
Y4nXcteDKyp5qQ9Rh6gCCaG6W84V9QyKQqAMvXhVkqQJY/clDuXL9+Umgmhu8dfyGYK59ki6
LamBAI8BKthwB/MAijtv6k1tjcJ3KQ+5oRw09DSid2trkpry0lYJBJKce3F874c5wA3GnOcE
aMNMkm33B2w5wPgps4lh75iD0ULZZyDVocWe+fYz7Mktkz2A16iFLznbnEi+PxEg7Gn88WnZ
B3GIHIM5YnsqdWVGy4eBdpkxH14q2P6tq1juvr9s/gbAeKgNJUBO5uho3QJWn/i2A72Ck7pA
rzPk3VPnqcxtdsOfL2RYvuN7Mea19O1vZZ0Ho0S5rS0oMBKulKt3HGOyGHEWMwep5cG4Jcae
+EKonNHtoA0H0RMPDSxXLBQbzFsWfo3E5fKSHyOO0c6wvAqU11oeo6tiAPJ767GCuVvXX0d/
pY7MPFe5mZ37A6E9PVANe1eAIoopD+QrUO4q8QnusKSi8k+PRBKI0ZDGAkXDvN6wYGGApVsV
PSKZZTpFt4PkWDgENrlQwwKDIPN/HjZm7MiIgbuqaYkh/NgLnvfEmPtt8p6BVgOWIcMtU/pW
CP/wE/jp+PgTdZrlLs78r8J7lhkAiECs1bIUs+N0TMzi5TjOlZ2QdcYK/xv0nuOOBbR5z8Ez
gF2Cn1hPQk9uHE38hrk7/diXeGphju9kW5ocrHNAbme4efd9uQX/8/L4zp0+T65CETQvZ/6i
KFB2LPLAtBt+qBA0JaWGyTMCwCX1h7TtQOXkzianwEXkZegNE5jr/F7IOiY0cA6IeagOfNKQ
BI4XLFYgxPTnsbNRYIZY8mTse7eqs7hoOBRxHoAzUpiPZ6Nz/zcwCaNFwAxlGfX7Bl76fRnE
y5n//OaBz0MyUgbqavH7iIB1ZIzheq785X24BTb28S+XBpImcBDEZiT8+QTAuzN1yzX1X/KZ
wlKDwAsKSIQfuoQRVV5mgVyiCoOsWpqE+QVGjuzC5ICuANQe4yqo8qVCkSTnmCu9M+4bW/zZ
eTHEx7M/PbUpDUCNdmApBmlNe5unOlSGMCE5BEGBz6UoCdUuJH5nEvu1iKSwPBm6lamZ0sAD
k5aM5J6EWENHgCorB3becixwU246OR2jDvuxWcbjA2K9f22v9XL5uI12L9GXZbRcY6z8iHFy
lBNqGXrfITYtCJhtWtzWouPb902vZvSWQ6vfoqVTHkiZ1qTmcWLw2OGc9adAxTDhqZ/AyokJ
pTeL1H9m2e0R5JUobcKFzdZqstnwa7T9Dt7Zp4qGY/ge1Oh/G5cly39WD8so2az+qXNEXWXi
6qFpjsQwYqvqJ9YJy8r+i5PTbGzA8u799stq/f7by+716e2vnvsF8XRepr6YCI6+SEhWPzO1
BlbWY6dc5jYjaCtXeomgW7MvHN3PsWfmhedZomFic8DLe1anBnI/qI0f23WlJMviwStJexGz
TNzaPHUvU9JbMoT3TbYp4NwsA5vJQBRTM2ApZzMMaHMuZgG0iGwE8x0ts31JDSUcAeDC6mZc
BW7GvhIN4n4QkQ9KbNpLxsbOdwv175i8O2jLc1ua0C0uJ0ZN4AwSrB1K3T3ap/cercI6JQGx
pLnSsRlzFWPBuf+SCrhtgTfOXLuvOTqxmxd4owEqyGg/RMLUa5irn6D17RXyiDrxr4bzE/nh
sJ9ddLXFVE5dkWyrJPRmsd4+2e+5o2zxw0n14lBxNoXz6hn4unFQe5XqQFQcIvAgRaZJcDil
0sRvECG2D3WyGyUChWFIDH7lgcR9fhwUqwYYB3sqSf5eivx9+rTYfosevq1eo8e9RXTPNOXB
if5kgE4P7liPAbU+JgCtbnmiJ+bcPZIBdXSUejlUmAHd/xmITwh/lOPhdL/rdPfE8MFibNto
KKRtDXx63pLDksMphWmBAht7l2L8rvjg0PPF6yvmI5uTtoDEHv3iAQzM4ckLwL1sjruCUVpY
GUtAFwNR7Vhq+fT194eX9W6xWgP+AdbGmIV0DauC0ixUGmD1XunRVfjOqOzYlpWTY1T47xjZ
2o8RrmG4zGS1/ft3sf6d4lYewAt3gYKOLwJKVWC9DaN0qEJtO9gLX0KoZQl2iwMhkd2vvKm1
DXLYYRJWkIybJPC3GFq2cRn6Ewoth7A3DF+CEMwc2wieHHiIWhSupqLA+vcTIsNOh++dZcH/
KR4+ccuErhZ/OM6FNwBLWk+sfl6QkFu0DPtP0Q/7TrjiV2cnVpRrf3Rv3UnBhuuw2pmVSSKj
/63/HeHzYfS8fH7Z/Ahd0rpDUKNKbooQ5jBVzF2rCQ3mNrOlQmoiAN/2v4RsGWIWN9//jM7c
2ZCagofLj3hD5BlnFYvDfsxOgvfbl1rTvcoo4dSCAJSpCq4DHxoBFb+Kxcr1/gCGEZnd+Un4
LWgdh3Zt9acb3e+F+3AELQCH5aA2u0Xn+HiV498VaCpVbSlE811Yl8qpmzz9mxoUX/1LUUFk
GQeySS0ThdjgiH1p2bLBU/kBQyLjcAmMleYEPWTYaYIf4ZVTTZOZfwSsU8UNNkz7zWg7xeSE
BAEJi1nOTCBitjRN5Jh5fPlq++ALDcDxQzyDf+pAXWSzs1FgVcnV6GpukjLwlQQEcvkdqp6X
ygqaCVVJ/PMl8iAu6sIx8BiEfrg69ycp8QJAX/BR5YWp2/wwOXh4o6Ha1uUJrERstH17fX3Z
7Pp7U1PgSAPJzob+6YLO/RhxzzCfX14fTKyX/y62EV9vd5u3Z1vSvf222ADw2WG8gsJEWOgR
PcLRrV7xx75wsFvKfxj9I0X7ejAxedotN4vI/oGir6vN83eYNXp8+b5+elk8RvW3nG2ig693
y6co59TGljVMaWmK8tTTPIPbedjaDTR52e6CRLrYPPqmCfK/vG5eEI0CNlW7xW7Ze8SPfqFC
5b8Oczco33647qzoJJCgnGe2RDJIJGnV5g8GIVjDVFfYJu4TtPunB5qFKt4i3k4d21MFIj4z
9geRhCf4QWKghl8NMsEOAbMJYWKT4g6ZOL9nDFQ4NLmQzithem5YvROLIgk97Vjr4r9gnysA
mvdHShc0C2F0QvElxUubzUMU6KUCH7/DbPCTEqGPB5nGtHtQUCTaWm4JPwQWpCu/VNBuZnZX
7ZeqAQlmIZdUZLmnNs5mcztT9OheIghidpvVlzf8G3vq+2r38C0iGwgOd8uH3dumH7G1R6Un
mGDUrhrMWJEIaUhGqOSa2T+Y0ikaPucRo5UvXdDvnZP7fuV/nyTdDzx7lEoKSQIDUwIhjPu1
GZy878/B9EaMpSAJwBdHrS/9EDymOaYLAwbcfvMSrE9I8k+hvzmRDIY8FJLdN98Cd3fItpjC
/k2lgoxZjmnkoXCHI2E5cubddP4RwMLcS8qJnDH3C7V8lofehnJU6v9n7NqeG8WV/r/i2qez
D/Otje/nq33AAmwm3IKEjeeF8iaendTJxKkkU3X2vz9qCbAE3TgPmUzUP4TQpdVq9cWtNlhg
FLPSkGmXg/bBO75azQgPdkma49c0mlTFqLl9531prxsT5qy+LvBxkcTSmUkqFlXMqDlx5WQ3
HXdMmg9uIGnso9TVdG0dBN1ytVquCbFE7FJMNWBUB3wVJHGzynvmLqmJdy/BlS/XyHC1uZxW
3OXoF+Rw45qjJO7GvLDdoHm53fhdIRt50vfv8SrBxFoeqnK8O3nMLcbBY7ae4BdqAF1PbCJS
oVCzxqpTxGBsfvsbjomUK46WfqMpq7yDqqG6TzHJw6hlH9pWBKFb0YERgboHs8yOt0G/2kP4
rXPC1CXVYT4h5koLmN5aDiU481mWjLpEzbRI7hdo/dnuSN01ak4BC329nhPyT5YRXs9RiBlo
F3yj7xu1jbRldilJzBW4uADEO/dA7clAzsBaqsBlO6DnIlpNiKBFVzrOBoEuhZzliojnCHT5
Q21RQA6zHdX6Q0d+0gctda89OjzB1fS/+vauv8P99/v5PPr40aAQldKBshfgHk6Qp+JeU8KX
118fpKgdJllhTWlVUAUBePlGlLeQBoEYR1lnaARXpgZ3eGRCDYldcLW40/eE7Z3WM8SNeAJ/
3++nzim+fiwFV6XBl39Njx2ARfb3HfVNU9wxuzY6safAtp68848qTKe1Oddl8iBxR2g5Wkh0
14F0AaBDRisHghoN1PC6hemuRmtI/IOgnFgaDNgRwVEGnxItrN7AboBEenAPRNCEK6pIbvYa
qM1xubOFlLf7fkNYzBiTbXimcTJimYYoI2fKYlYB0oLtuGTZPuZxULcjtHdqXep6y8kM52z1
lJ6W42pTCGqENUpNoo3vZ5RZ4RUlwkgg8w2Dej5LvcEaXREqwwXhEwZ7zeKSzCSpkYNM6eDn
cqYPYY4+Hb1ZI1g8GeNBxjW9tRuqdm4mh34AWqhfQy0+xJ/s9zyFgHYgYd/qU6+MpoNzgsXu
lBJwa96dsnrSyJNlTizVPA5nSr/R45i709ujUraFf6Qj2HM6qtg8xIx1Ea28gpqzfuvGPqrd
ZD9Ob6cHuWcYyt9GayAMV669cTBnWo2hzeQj5fDDTWQDwMpaJ6Casjug6GsxOFTZwaLAW2W9
qjJxNN6qXc/IwjpKoWP3phuBL762lqKCSVdbjrO5OnAebkMmt0kdROR69Pb3d7Kor9Q7vz2d
nvv6kLp96naHmdqLmiDP0GO00Ai8o+Lf6MHpfrdCBnBGRwN4GKDr8KB1dNSECCLJVbxhI0ag
Sc0hmkDstxD0JToCIsE5rS/ihNWM2eLDTUgunNUKO7GZICT3QE0GmyTkBlebyV5evsDjskQN
vFKeIZcLdVV3W28DsTqGmiwl4Sl1mLIgxAFVQ2AAumcmG2HH6jEK+0u4Wby1JXH3XZyxpKSC
gNaIySLkVN6JGjSUfqKG1DrCr8Ldwgd+AnoLFgbloiT0ODWkPoVm/GZlkncPkeV0rqLsViXy
L7+EaCdeuA1ZGhH2h5Kf1zGZ8B0si8M6zB/+vOTJA4F48umayIkB4VEHbDYFkz8ZXqnsyOi4
Kfo2fKHDsEUTOpiCSdtOXnutCSeDQ2sTt+ZkBRdk8ekddkh2efl4uzw/y/8i9jjwqJ5C+FgB
uQzVbz/ZdjQrBmgTio3bUWbJ4lrlTNbt+eBEDBa4RL3dkxCUhTH8JizyAAATsHNFaNFTCMqY
4HIO0LPSdcoSnMRJCOj1SPsbAOjVRJK/HZP7OKu299hVJpRlb5ePy8PluR7G3qDJH+pQDGSw
JgBr5V4AWAslIn/hlARXyAj+veP9FmcZx2Z2lvUXAZTVmYwuKo5l85Smimz08Hx5+A9anciq
yXy10iEEKVVMrSkDvQLpa2XoZE6PjyoAiNzV1Ivf/89wUQ4TJvKo9XB/ehk9tMvp3cbJ/113
ksZq+kowRCow5q5rxnV1mla5MS46NHQpxW0jbOE0gOte3zRLribZN5YpTXeF6faRVmzqeKLC
/fX6P9YWUz9Pr6/nx5GqAVF1qQqWM7m+wBKcfscAV9LnzQPllaXI7QgMGaVpZD78sXUv0oBY
TkYiqKSi91mB7q7A0510/u+rnKzGNSSs/x6l14ETYufSbXLL5XSM3whpAJtOVyt86WstU8hT
3reZhrZd3tRWdqOJMcucKR+velUUfDPw7AFvtI574O5xnZSm5j5H7/c0FYKBR0fL5sso72+u
V5jnaiguCYC/BU3euELOY1k9d5ZEd1sQ/OsbyObekdIlJuM3iL71JNuB8VRehTybLAnjyQYj
p81qPcaMcxtEl11cn4RbVkoGo4zf4Po8dnE2qLKoeCkq8MA9wjU4iJ6Yl5enh/cRf3p+kjx6
tDk9/Of1+WSbF8nnsK5jELunU93m7XJ6fLj8HL2/nh+evj89jNx441r+J51cEnpR/3r+ePr+
60UlwOkbetePyqXfsxWBMsgnIuXnyC8ZZdjeonYRI1wqAOO56/HcIaUgBYkSImWcJMZsIs8o
5WAFu3AxcyZVFhPMcSfA0pKHDDX2DhpL38r1WLcj7vw4iwhzY2idWEzXeGY1/xsIbpQlrHx2
H2YQO4PMsiUh8kxfwmUQCeDxnOCt7qacj8c9RZn9tIizAeqRM8oUXZKFFMjj6XReVoJL6Zqe
ASLji/l6MjwHBLUFq3mWh9/SxB2s4BCvppPeNGnOUI3u1DLvahWq1HHmigjC0vcgwYc8CPt4
JRAJstDHSV7EBAO6wsGjTwWK/uwDpGxwhWQH4nDZItRYOISaNva90MWSg2ifzLfT6w9gbIg8
7CGaGpdlo3+5vx6fLvLklzVWhL/3EoAqcPB2+nke/fXr+3c4HXZVqYEVDrf1qpTNxS6fgk3j
+Wa4Z26qJBVhYO26stAj5q0kKQe7vc/RHjGBTP4E8qSd+0Ro9xrD0uwom41LkjUmjOX82kTh
YEW5v5dCUelHHBxLISsh3gtgwNA0zOoKIDSt6RHaJnS6Ssquvjwi1+naqPapd1KuckDfb13K
fECSY5dBrBfycThJRqCrJyuASDHaUZasRISR+sBuwP7+TPzR3CggxwdZ0fD1JHztxFO7F0mP
OSsCklx4uEACE2UTV9tSzOaE4lJCaoZE9lRj8ET2NRjc8R0VdUci3CKt7ibrMSYGSnJfAoRP
DsGNDZUb66GtpDzRT5gDhSqcSe38a1YLtGgWjMfOzBG20GhjYu6spttgTETXAIjYT+fje1yf
AQB5hFo7Dj5kDX1KJH8FuvBSZ0YEMZHk/XbrzKaOi0vHgBg8R9ZfKYWCu2CgI3blajrHxZbr
MJi9jULlUlZxA3trSLL498uzMq2Xkm/juoRtHLKKRtmNTAnt98C62nGrWP6Oijjhf67GOD1P
D/xPZ97OS0jOqf27sbsZhCy7ACJFg/I37iT3GnwMrk6JaH5RurXOLvB3JXesopQMjAidZGBk
rxFuswaIRYVw8ARpaWE7KKqCSmdwwhWgVqTDxNNpAuyijMV2gRe7WlPbJ311zSCaTUl9C9yx
kQEq9+8LUN9SeXelIC73wxw+gUTIRnTpHWrzUdZj3jFx5bkCYsumlCNA0vKrKo08Ili2ekue
sirg3XfUMfQUmQiTbcPIWwjVYlJ/ANTcPcShF0KXkpg0i6YQUOQWaHYTxDfuwR9E+HExGd9N
BjG18V+Pz+y8L0rANK59wTcTtCRSsoE8Dzpyy2LWaRWlklcTCXUyAZI8iHVHDgz1INcUvmQb
ROFOiFNag2Bu6NLfD4iFFHuJ64sasQsDKhkPQDbMcyjzi6aKLCXuiK90wrGuQYg06VlK9EB7
eaBz0fthGJyU2awBrEKMQOwWT7GHVQLdGBJBELchSaOyoLJj6+XT3ARVodOfc/zCRvpUA/76
wdv5/P5wknsdy4pWbcouP39eXgxoExO4/8i/La1Q/RFwbeRy6m7TAHGXnsgthvJSMjGZR8QW
MlH+rdeFcQmroRO70+TyWs/SG+JrOfQ5SUMyil9fTbM8oJcC/PG6I9qtxGE6zYa68axHxvMZ
Jv63E46tl5VGDb3f9dxiKQXUYdDdbELoRQ3InIjkdoXMpytcPGggG4j5RvMsgDA+c5YTQp/S
gOqxUZ+PjYrPV1MiI2y7skW8GGCOaliSJK3yu+l4OvxVMY9X68miOjBP3eUL4vDT4CULmSzX
tGrRwE0nixWtfzKA84nz35u4XMwXy+VNGA/zQO8un5hgt5cw57GzGNNquBYHvq9EHNEGI6K9
POS4IXN6PrA97CFezSf0vlNDlkRwNxNyYyoBZHq7lil+8DEhs9u1EI4BFgQ/gJmQ5e1alsOT
XkJW49lnBmG9wo+9CqJO5VU3wDyG4awYwKmTBJyUEPPM0Os7A8hCk3HsIC16fYEEoQOTLeEC
IYFSkkVJxQ5VC0LVtRjR3tTAjcrpWbUMYfHwhDsDt0mqCZL750SgakXNMsJZtKWGxEUV0AsQ
Yknyxo/uQiIipCJD3uEAZwkAYDs/J06zmhzKv2i6PKt4IZhI0zUofTJNPtKpYYAux3ebJnlI
mMEDxI/50Bf6kU/dXmkyvgMq2rdOUHaLuvXjTUisAEUPCPUMEHdp1LEatcjyvcounwYc6Q4p
WJRuQyq/gFcd3EgQwT1Uu485nf0NACGYUZFUcQiTHaEa1p+WgKUI5RMAkIjRF9iK7ifpnh42
+PrB9Rq7snto3woNOdJBrxQAPA15GuBnHIVIIfPfwARSgeiHhzkRORGBA6jyhDUwhzI3gfvs
KB2Yo5mfxGDUPQCQ8tORsBxTADCWZANviFxwt09CRi9ypVOjX5GnjLl0E+V5ZKgbhtyCFD3z
fY/0ylAI4fsRmIlSWQhD5TGURYQbofoGynoNFhz43rh8gEvy2M3F1/Q4+AoRDqwJueC5T9h+
K/ouLyBkUzcwoc1YYLetMo5LNJq1DPHaMpSzjaR+8/N08AO/HT250w7wDR2UpdoRiTLVdhoh
NoBwt47KJVqh0pNNshDvyBqOO/8BMd0xeXgNhZASlL5BMzwyJL1336G0Qk3iZaOszWG3Y55F
6brGuvLUVCQMgpwfsICpbdyi8zNYp1x+vave6GVHgbqagPZwqxZy0X3VJ3Skqg8EvhZrWnXY
yeUMGUupPhQQwEndT3ABY91tB2XcA7SD6tCNG+BzAILmDBsoq+cXy3I8hq4n31PCQA8B/FuA
tCycyXiXDYLAhmqyKG9ipgtnEBPITpVvG8SA9wPY1ww2+tZX8Wg1Ga4iX7mLxXy9HATtmI6N
qy560aGsPWbZ8+n9HZPq1dogfC+VjhO06wQrVBPJo58VdkxI7bGSCv/fI9UFIpUyrT96PL+e
Xx7fR6AihBhCf/36GDWBybg3+nn6p1Eknp7fVcxyiF9+fvz/EZgKmzXtzs+vSqn48/J2Hj29
fL80T0JPhD9Pf6sAo/24ZGpYPbYi9MGSHGbUZZB6Vo2FZ4d/uRJScg0r+tb1tn6PiyiSByY0
eec6UNs8P58+ILfZaPv866wDDdtMSj3f3jlr9qYmROxC1C3L/k5hwTY0TSJcTFONOTB8w6uJ
tO8/WOSHHmHr0azNpe0G045bJyCQvYyUzwr6mM3Lief9OFzQzZZUB1c3qFXjFYI47eqm7blP
c/g8TCljBRUtwd+mgpT9FWKALdSHSfl7yRb0mLGjsvOkR8WjzwaKWwovlOdG4oyj+ggO9Z4c
3YhwX1U9FXL5a7+lpwdhcqh4TA55jPbhJieTCKhPSQ+QMH0AQTpk6F2Kq/BeHELel6Ig7p70
VAZzgYBQxkjAUT5NTxv/m+rZciCQBmQDkf3p5702t5M/+/HP+9PD6Vkzhr6hq1rvO8MjN0kz
vV8zP9x3WZEyG993PKdMesPAemVtpm27Pk2rL3DJDzWrAMst4tTRhw63U30J6FMOVx9Sg1pv
JlVSxHXge3Akvfbs+e3p9cf5TfbtVUDqspVA/jMdWN2NmFEQ9naqOfkguREP6I27dJ0lPc/i
/WD1QJ4OyEDwbnqKbjw2WHviC8dZ0s/XQzHgq6U3RzBs6YhH1kLZQJTwlIdm/jt1A60DxNmF
QeWbhhm6iBcb3t+b9X8J2wQAwBGOZordG3Jz+Ytd92UQcCmXZyT6bYDwfZqPy+U9IOHpzh74
mECem0APNgCJwTaqEcPoZvS3a7sWsMTQzRmo5JZEyuTka8d9oB4p9VbxAEvRaqkB+m7g9Lut
vM0WVy2qCRiBbyYVbemAeUPEsW2NHzM6Qekh5/69FF9i42K5LtTXFtdiqKeTVrwtqk+wf67s
12raRh2n0Q/gcEdH+hlDFejGJQl/cO8PePozJ1Coh3s7whlUUSkDeei7A97HWJhzWbovSIYO
5ILvCIt/RfR24UJK8fTzZGx0P6bj2oAmQ0pX+CRyGfPBc0ayUDSqWi5YZbkcQoGycbSLdkyk
/IgXNranv719PIx/MwEQVFKege2n6sLOU22LAdKb0WrAc4hqZoaiMp6QvCDQfo/2y1Q5WJAh
xR2TOrO8KkIfjLCIVCrQxHyPT19wvYOWdmKXwiS0i3vVxbOJWONiugUhPOJriMcnU8KiwoLg
154mZDbcFgXBBQ8Tssane/tFbrlYE3abDSZfLwljiBZRzuaEb94VspgQF+4thM/ZdIZfp1vt
vdG/GQuciXNjJFm2XM+JFYmY3MD8AZ/p/vRCen3qTD/TwuHBy/dyHq3t47ytc7jRDhanOFMy
podD2OQYkDlhA2FCCKMCA7JYzavAjUNCsWEgl0QQ1yvEmRH2SA2Ei7vJUrg3ZtJsJW58PUCm
wwsVIHM8QlYL4fHCufFRm/vZ6saszrM5u7EMYcYMLzEdWKE3pS4vXyDruT2hOo/2d+S2uxPC
77htetfZujW94OcXiOJ+YyYblymiY8RRI73YvYYcb5+/lhJbGmjheo5dkHJN23Ma1v2yrPWl
27mQo5Db1DSw/0b8TMBakYrAriIrg6rHJfzWVbTdHQCqeBvjMt0Vg5K9A7SsrwwGPHt+gnQE
Zu/rLHmiJKPGexBeDtmCZbk8shuXNleRFGoEHQIuLBXloJKKMGiGcSGtsfdPb7IV2OSCx8AP
v+PjWd9APbxd3i/fP0a7f17Pb1/2o79/naUojMV0Eu6247LVSI1hxlvHmAqZnts08oKQY6GA
mUpPB3FK7gozsprKVhndgSl55uZWcCa4lQNaaySq7X2ZCheiHMgg9qrZ9OszFRW5yYBQfpwm
pMQnigkJGbE3GqBYOJTE0UPJAeSEvU8fG8bbz4P3ns8+j96FwefBvth9Hrzxsg7YDizIX59e
1CB3RF498vzy6w3PpubmtXeJlHNWxI6qLdMzwvWT7+oKGMGQWkAsCsLKuEGIuEABfttIQgsQ
u2G0STHj7lB2ZWFcYmuP4TqLqyKOstPf5w8VF4fbkXby88/LxxnyjKAbk4q+Ceea/inp9ef7
373ThwT+i//z/nH+OUrlmvzx9Pr7NXRCJ1dJG1sBTPUxI+8igZhTVMobZQmLd1Wm2FCQE14t
fgnZLKgTcErY5YWoFk1yC1PpEbeHw2tjZCFsiYHAQv0Dtd1Cmzfl93UEfmMGb+GK3y2rJP9z
YgA195VCjfG4jlRTZ8u6tj8DLy9KC6SCptzK0REgN6zZ7ijn1F/vatCt6C9N6J0d3p8QjUky
0spZJTFEk8I1Ghaq4Bt8dW1YXN1BkAJA0G+EGy4yKISdAkN/2/kNDiCnF8lY5B7z9HFB/Shz
t8+13JfHt8vTo8WHEi9PCSUepLeicnhTkYpBkLINdLUPNaQ+svz8jTV/Hcps2w9bEjQJkxD9
V+v4Lxvaie+tYOL899vJSLlk5TQKniTn0VPETJtSCqfjkFcXVSVk/kGWi6RP+49AEYRuCcvK
ZbgupUFxnxU5rqOSkFm/7tmn6p5RddsgP2H5MSOtPBWGUrN+3XhWSlX4mwTL1sQblUTcjpcR
cj+XNEK3/pUmlTRpG3CHooFLJUnciIG2JGE08Gjg0E9S49V2MmyT3XHWZbWyGU91BfJ8BXQr
om8MAXiF3DS6dLM9+Li39H50DE8XYZu9pqgQJtZb3P4j1wNTkRKJrRSFEamX3UKkAZ+RHQ2Z
5qmB14kYKyRAHDs9/LANYgLey3evyd4XSMwM+QiBg1wZyJUL8nS9WIypVhRegLXAS/kfgSv+
SESn3rYvRYcRxFw+g1/17lu08XRjsweuQxlErZlNlxg9TCFyFtz5/fb0flmt5usvEzMHvQEt
RIArehLRWwt693o//3q8SJaMfOHVF9osuLOj5KoyCEQkrDi4qhg+Ckz+QsoMQqGkGBN5ORrh
/s7PE7MBHaW6iDN7BFTBDUasMb29o6Xviq0voo1qPHYYVb9UZxrrO+T6KK8zV1ltSnNXylo0
J3K9AVpA03aDJDDWJVnqQGs2NKn/VLsjaCZ87Y+mpLa1GPfKD5DsTJsyWNtVS5c0MMbA2ZuG
8SL+X2NH15y4rvsrzHm6d+bcnUK7tH3YB5MYyBKS1Emg7UumyzJtZ08/Buic7r+/kp2ExJbM
PtFaij9lWZb1gdEeyO850cAg4FMsGiMBq6UiiBukey4IjgHH95Skb2AKL2lujaqcMO5Adbd0
aJwkJSPndlEytBqKCmLoBo4u9SfbmYpVWip6GNBRi8KbEiDXFVo3mWznikCAGonSe/Owd2S6
GiB0ZHRf9Ka2ghNSUQA3QC4ww00p8jkDXHlklmWUAB85AcSUZdFK+oIupUvPVs142E1ye+GF
jnmo8jWaoVkE805+l6/Yg9IjiNXRczs8kCCrpKsnhn+aY6t3rnXAzcFYwcHY/7CFXPKQy68M
5KqbWMCCjFgIXxvXg6sx2854yELYHozPWcgFC2F7PR6zkGsGcn3OfXPNzuj1OTee6wuunatL
azwgwCF1VFfMB8MR2z6ArKkWeRBFdP1DunhEF5/TxUzfv9LFY7r4ki6+ZvrNdGXI9GVodWaR
RleVIsrKLsvGUszXB6yFYXQNRiBjLv3NESUpZMlYpLVIKgXmeqqxOxXF8YnmZkKeRFGS8VRr
MKIADYsZ3UyDk5SMfrg3facGVZRqQT+GIAZK+b2LYOwGd1xsd6/bfwZPDxtMMXcU6k1Wl0jd
TGMxy22F8Pvu+fXwSz/u/3zZ7h9dZyMT2qiqJZyjUKwDasXpLJYrGbeMvb3PLEHcwv3oYFx0
ZE+M51jXH0ru5atxZaIfMYO3l3e4y/zv8PyyHcAVcvNrr0ezMeU7d0DGQDdKpkRocyytlAzL
gHHP66CByM2sfAcpXAs1ZWJxh5MqD1SUFdTRKRPMFVbB50kn/81xBWr4sswL9Bvv2s7pyGf6
y2/Ds9FFe5cqoC3ghqiNXnYtlaQIdV0A6klsCSbXQ+RJGjNyBa5wuk4kJXo3htCdBzxoSaq8
7a81YbnUJp54uVpifGeiThvFzA96jLjVTVMFhL+WYoFOcqgNJyrU3scoBKlO1tROYXvRNvP9
7exz2B8f3lhlmwWgDnMfbn98PD6abdifLJ33J+eE2jr+PyDqUFn8nGcpsPaETR+uq0kn32G2
6IWrJzwWlJWnfmetR6fzP4oOcf1ZucnyhJvfhPu6ODuzG29RWacHC69ZiZSJL1CPqcAHjTLn
jIAN1op6dTEg89gDuzfqeBN0pkQ3gIqsaZyu7fHbQLtzc+DDruIJqWUQv21+fbwb5jV/eH3s
abRinUagDnvI6FbqmIjzMgGmL3L6aFvf+GKnZwKfiPCSnGZdNVC3uFqJuJTH5yYDxOMhLYvj
zT+HTR66rhemGFkjfRtBMEawZG52+muzxHD/MozEs8zYq4WUGbdRmrdVQbLgejeCmLDM2gMT
l+m4vwf/2dfvz/u/By8fh+3nFv7YHjZfvnz5by8cs65LFcCwC3nLeJHURALdtXOYWCinK1mv
DRLs8XSdCSZki8HV2m0Pw1FA0I0Km8TQFeAsehoRRYqHuE6Wd6Iv0AwGbARmH0+ROdDj1I3C
XkBHKIeHtEceUIoWgNy9uDD80deXyMuYMJOOHyP3sWetmI+4mMgGJwBRBOTmSMSuIlcFJXPO
6PVCMLmFdDJeBOMhwjoxcBN71DdgBcDn/Bgn1gdR4FzGdYrjloeMhlYliguiiFB5Q9i32bvh
ppYGlCMHWJjmqQdOabQVYOT6euEqqVSqgJd9N0IJ/RpiFPpenBgkuyS4s8LAdE+exvvFTIWy
zqUWOlMim9M4jRA9bXZDrwJzR1jqlJIgDwapCi0UVPjrNUJMTTi5hRHUH5paOjp7+AJ39PHi
cZwcZ2UNZX+8amm+2O4PFm3Hi5B5+dZ+kToKQc6pFicNM9CcxUO4kwJ4Pg/XuwZOwcqPBrsD
aZuFG444vmj5HD+uubwNyyXNNzUCyvbJzBtlXeMtALFIaXc2k6wGb2O0fKXhk6hYMrYSGl6W
jC2Dhqq5yOc6CbJnrFygHzT+FFSmO4sGFh4CwfdRHWffM8LMM/zG3sHTAn+RBcnSv8x4hMIe
ZUN4aakeroOiwBDdSpW8ejwX6GJFSTV6s+qQJZiJ87hP3f862RjtmNwazJ/NGgyCR2Wu/rDp
aJLReIuQfnbRfVwL4DRVOclFAoy3SsqYcd1DDPqhwCSeQGUD/alh/PeojGBOTCOPedLl6Ydq
UxHx5JpvNx+758NvyiaYXevGbATIXubaEgu2OCOueE1MGiD5kqeJYS4USBky1LsDN4cRBuvk
LA7ZOOhdwnCApFxtTsXjEEXQvUj1od/+ap8I9INQ2pr47n6/H94GG4yz8bYbPG3/ee/GnzDI
MJSZyDrq317xyC2XIvz2QhS6qJN4EUTZXCoXhDyMLHRRVTJz2oMyErHVoTkdZHuyyDJikPiU
1zMbatrIGRNmAw5pxlxDZRCSxtwGWucAc7pel1O9QRI6WWEVRrnWXmluRNQymw5HV5YzXR8D
mYrTLyx0Zw7fvG5KWUqiIf1DH35Nl0+jiLKYgzDoQyG9DsTH4WkLYtPm4bD9OZCvG9wcaOX3
7/PhaSD2+7fNswaFD4eHnhl83XnGObuZRD84mAMDFKOzLI3vWO++GjeXNxEVkqulormIkmgF
C2LsgbUdNwaL2VPdnninKmBMPlowY4XedIU+mGpwrOj4GjU4O9G3W3/jcDCsFWFROX/YP/HT
YTm4WAwIoDCtTkdOdHRFes08P4J07nDbQAXno4DcHKznQ4tQDM+4gMkNGbLCYTPpf0CAy5DJ
c9iA/V9HQKAg03CJ7RpOugyHTGzkDgaTdPuIMfpK++gdMbjENs1um4shTxEAhRYImgDA16F3
vQCDdntsuNRMDZnoHA0vzawmDEHryCZ79xyXFHMXSTlhglI0GCrwLjdc+Ne2G5JDm2Ip45gJ
Cdni5IWXcBDBu5hcjq0aPNW/XpYxF/fCe7rkIs6Fn2AaVu5n4czrWAtXmUy8fS2YQFwNeJ3a
i9K+9u22+73JU2fP3xQ1Kc6ZbeyT7BauGJ/U9iMv1QB4Tni/PLz+fHsZJB8vP7Y742vTpNRz
CTePqiBTpO9cMyA1wUtjUjrCiYZodu4OzMAE7Vh3RHHq/B5hjG+Jrh4g0rssQV+d8f59ige3
iHktlf4RsmJ0yzYeyuKeI25NzYhcaV+bQIhlO/8mwbyXh+N30XJWyMAZs1nR7e6ALkwgV5k8
Ivvnx9eHw8eufoi2dFeTKBHqjtCwmHeF5x+7h93vwe7t4/D82vXInUSFkujeKfsXreY+doRT
GlYdPVrEx13ReOAkEq2Ho56FVic1dhBVUarzJy1F5n5t4CTIygGsAhAugbbIRQuGYxvZKwVA
7UVZMXWdW5cIKCB1a32EOArk5O6K+NRAOD6gUYRaCybAj8GYMCYCAKUDIGDAKC1EcZ/RQgXG
cyoMPeDlThTNctAaTpGE6dI/PWjAiQ91fZ6qSx1OCyy2tbHtl4ayU962f3tfcckzDKiaBN9J
dUWOVCc73nWmyCVULA+XnVya4U1nEyQx2gu7tNvoZHvUkKqQmccwpJkbuuCBKErdOWH+pmE3
92eaFG6oYSztzZhGu/qkF78GMoFMNHT8yQSy0NDLzyFN5hqa4WO+v3EBk5T4UdB+trr49Pfx
jJixeoYSHKAzJVA+HH2O6LNcYwzPPodMkpKZx4YnR89ARmPYBnwGJH1dJXqdG015t8N1CIXo
3ono/3+shuV60OsAAA==

--r5Pyd7+fXNt84Ff3--

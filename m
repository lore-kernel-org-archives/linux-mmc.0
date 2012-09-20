From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: Re: [PATCH v6 9/9] mmc: dw_mmc: add support for exynos specific
 implementation of dw-mshc
Date: Thu, 20 Sep 2012 10:14:13 +0530
Message-ID: <CAJuYYwQpjhA0O7bg7AVGOvi2Np9kEdbv4xqjFDB4p_XTDD+CjA@mail.gmail.com>
References: <1347905803-22742-1-git-send-email-thomas.abraham@linaro.org>
	<1347905803-22742-10-git-send-email-thomas.abraham@linaro.org>
	<001501cd966c$ab1ef6e0$015ce4a0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <001501cd966c$ab1ef6e0$015ce4a0$%jun@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, will.newton@imgtec.com, cjb@laptop.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, girish.shivananjappa@linaro.org, jh80.chung@samsung.com, patches@linaro.org, Thomas Abraham <thomas.ab@samsung.com>
List-Id: linux-mmc@vger.kernel.org

On 19 September 2012 19:12, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> On Tuesday, September 18, 2012, Thomas Abraham <thomas.abraham@linaro.org> wrote:
>> +int dw_mci_exynos_probe(struct platform_device *pdev)
>> +{
>> +     struct dw_mci_drv_data *drv_data;
>> +     const struct of_device_id *match;
>> +
>> +     match = of_match_node(dw_mci_exynos_match, pdev->dev.of_node);
>> +     drv_data = match->data;
> In non-dt case, match has NULL.
> Needed to check "pdev->dev.of_node"

Since all current users in mainline of this driver on Exynos platforms
are device tree based, and since Exynos4 and Exynos5 have device tree
support, I have mainly been adding device tree support here. Only for
non-exynos portions of the code, I have ensured that both dt and
legacy modes are supported.

Thanks,
Thomas.

[...]

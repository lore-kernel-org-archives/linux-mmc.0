From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: Re: [PATCH 3/6] mmc: sh-mmcif: use devm_ for clock management
Date: Tue, 01 Apr 2014 12:25:10 +0100
Message-ID: <533AA216.20504@codethink.co.uk>
References: <1396347954-13740-1-git-send-email-ben.dooks@codethink.co.uk>	<1396347954-13740-4-git-send-email-ben.dooks@codethink.co.uk> <CAMuHMdU4mcz1u0ghpWduuh1LzsbHGxu7ZkuXses4170rz=g3Sw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdU4mcz1u0ghpWduuh1LzsbHGxu7ZkuXses4170rz=g3Sw@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux MMC List <linux-mmc@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, magnus.damm@opensource.se, linux-kernel@lists.codethink.co.uk
List-Id: linux-mmc@vger.kernel.org

On 01/04/14 11:59, Geert Uytterhoeven wrote:
> On Tue, Apr 1, 2014 at 12:25 PM, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
>> -       host->hclk = clk_get(&pdev->dev, NULL);
>> +       host->hclk = devm_clk_get(&pdev->dev, NULL);
>>          if (IS_ERR(host->hclk)) {
>>                  ret = PTR_ERR(host->hclk);
>>                  dev_err(&pdev->dev, "cannot get clock: %d\n", ret);
>> -               goto eclkget;
>> +               goto err_pm;
>>          }
>>          ret = sh_mmcif_clk_update(host);
>>          if (ret < 0)
>> -               goto eclkupdate;
>> +               goto err_clk;
>
> This goto doesn't look correct to me. If sh_mmcif_clk_update() failed,
> the clock was not enabled nor prepared. "goto err_pm"?

Yes, I think the clk_prepare_enable() call there is the only failure
mode.

As a note, we should probably check all systems that use it and see if
we can remove the clock management code in here as the pm_runtime will
also be doing this.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

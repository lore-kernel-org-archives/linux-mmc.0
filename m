From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: Re: [PATCH 2/6] mmc: sh-mmcif: use devm_ for ioremap
Date: Tue, 01 Apr 2014 11:59:06 +0100
Message-ID: <533A9BFA.7090503@codethink.co.uk>
References: <1396347954-13740-1-git-send-email-ben.dooks@codethink.co.uk>	<1396347954-13740-3-git-send-email-ben.dooks@codethink.co.uk> <CAMuHMdVB6ZB0rnH5ekRd=NCy3zbFSTf0BSH3J48yDhF2YbNoCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdVB6ZB0rnH5ekRd=NCy3zbFSTf0BSH3J48yDhF2YbNoCA@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux MMC List <linux-mmc@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, magnus.damm@opensource.se, linux-kernel@lists.codethink.co.uk
List-Id: linux-mmc@vger.kernel.org

On 01/04/14 11:55, Geert Uytterhoeven wrote:
> On Tue, Apr 1, 2014 at 12:25 PM, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
>> +       reg = devm_ioremap_resource(&pdev->dev, res);
>> +       if (IS_ERR(reg)) {
>>                  dev_err(&pdev->dev, "ioremap error.\n");
>
> devm_ioremap_resource() already calls dev_err() for the various error
> cases, so you can drop this line.
>
>>                  return -ENOMEM;

Oops. Will fix.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

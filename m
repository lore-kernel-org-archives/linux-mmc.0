From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/4] MMC: omap_hsmmc: set platform data after probe from DT node
Date: Sat, 13 Oct 2012 13:37:20 +0100
Message-ID: <1c7b8951-3bf2-4433-8c6a-9d70ef47b3c4@email.android.com>
References: <1350039495-360-1-git-send-email-zonque@gmail.com> <1350039495-360-2-git-send-email-zonque@gmail.com> <5078295E.2090803@gmail.com> <50782F82.8060206@ti.com> <507833ED.8060903@gmail.com> <507835E9.9020200@ti.com> <ae718323-6d65-4e69-b8f9-6382c6299294@email.android.com> <507920E0.2050104@gmail.com> <CACxGe6tGYrO8Z0MxiOV+rjBprRxzT-4v6CiBh8wV0Avufd0doA@mail.gmail.com> <50792BF7.5020908@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <50792BF7.5020908@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: Balaji T K <balajitk@ti.com>, linux-mmc@vger.kernel.org, Venkatraman S <svenkatr@ti.com>, Chris Ball <cjb@laptop.org>, Rob Herring <rob.herring@calxeda.com>, linux-omap@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org



Daniel Mack <zonque@gmail.com> wrote:

>On 13.10.2012 10:48, Grant Likely wrote:
>> 
>> somedriver_probe(struct platform_device *pdev)
>> {
>>       struct somedriver_private *somedriver;
>> 
>>       somedriver = devm_kzalloc(sizeof (*somedriver), GFP_KERNEL);
>>       somedriver->pdata = pdev->platform_data;
>>       if (OF)
>>               somedriver->pdata = devm_kzalloc(sizeof
>> (*somedriver->pdata), GFP_KERNEL);
>> }
>> 
>> The bonus with using devm_kzalloc is the driver doesn't even need to
>> do anything special to undo these allocations on failure or release.
>> :-)
>
>Ok, understood. Will keep an eye on this in the future. Thanks again
>for
>the explanation.
>
>For this particular driver, this means that both my and Balaji's ways
>of
>fixing this are wrong?

Balaji's patch looks fine since it uses a local copy of the platform data structure. It appears that the driver is already creating a local copy and Balaji is just bug fixing call sites that aren't using it yet.

g.

-- 
Grant Likely, P.Eng.
Secret Lab Technologies Ltd.

From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: Re: sh mmcif cleanups
Date: Tue, 01 Apr 2014 22:13:09 +0100
Message-ID: <533B2BE5.7060503@codethink.co.uk>
References: <1396353706-31864-1-git-send-email-ben.dooks@codethink.co.uk> <1736383.oJDPHdJZPn@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1736383.oJDPHdJZPn@avalon>
Sender: linux-sh-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, magnus.damm@opensource.se, linux-kernel@lists.codethink.co.uk
List-Id: linux-mmc@vger.kernel.org

On 01/04/14 13:45, Laurent Pinchart wrote:
> On Tuesday 01 April 2014 13:01:40 Ben Dooks wrote:
>> This is a second round of the mmcif cleanups
>>
>> Changes since v1:
>>
>> 	- fix issues with devm_ioremap return, and error printing
>> 	- change the initial print
>> 	- fix issue with disabling clock
>
> For the whole series,
>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thanks, guess this is too late for the current merge window now.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

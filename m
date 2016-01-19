From: Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Subject: Re: [LINUX PATCH 2/5] Documentation: mmc: Updated the binding doc for
 Arasan SDHCI.
Date: Tue, 19 Jan 2016 20:03:01 +0100
Message-ID: <569E8865.1030504@xilinx.com>
References: <1453213055-35563-1-git-send-email-lakshmis@xilinx.com>
 <1453213055-35563-2-git-send-email-lakshmis@xilinx.com>
 <20160119171940.GA7207@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160119171940.GA7207@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, P L Sai Krishna <lakshmi.sai.krishna.potthuri-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Cc: Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, Soren Brinkmann <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Kevin Hao <haokexin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Emil Lenchak <emill-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, Tobias Klauser <tklauser-93Khv+1bN0NyDzI6CaY1VQ@public.gmane.org>, Sudeep Holla <Sudeep.Holla-5wv7dgnIgG8@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, "Ivan T. Ivanov" <ivan.ivanov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Vincent Yang <vincent.yang.fujitsu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Haibo Chen <haibo.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, "ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org" <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org>, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.orgHarini Katakam <ha>
List-Id: linux-mmc@vger.kernel.org

On 19.1.2016 18:19, Rob Herring wrote:
> On Tue, Jan 19, 2016 at 07:47:32PM +0530, P L Sai Krishna wrote:
>> This patch adds broken-tuning property to the binding
>> doc for Arasan SDHCI.
>>
>> Signed-off-by: P L Sai Krishna <lakshmis-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
>> ---
>>  Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
>> index da541c3..2088d9f 100644
>> --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
>> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
>> @@ -17,6 +17,10 @@ Required Properties:
>>    - interrupt-parent: Phandle for the interrupt controller that services
>>  		      interrupts for this device.
>>  
>> +Optional Properties:
>> +  - broken-tuning: Indicates tuning broken in Silicon 1.0 of
>> +			  Zynq Ultrascale+ MPSoC.
>> +
> 
> Make this a standard property.
> 
> Or use the compatible string to determine this. Si errata is exactly 
> what they are for.

I still think that having interface for runtime Silicon version
detection in generic way is much better than using compatible strings
for certain silicon version.
The same board revisions can have different silicon versions.

Asking secure monitor for this information and based on that setup
quirks for this case would be preferred solution.
I want to spend some time to share information about silicon via soc bus
to user space and there should be similar way for sharing this
information inside the kernel.

Thanks,
Michal


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

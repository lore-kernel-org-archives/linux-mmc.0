From: "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 1/4] mmc: omap_hsmmc: Convert hsmmc driver to use device
	tree
Date: Fri, 24 Feb 2012 14:02:36 +0100
Message-ID: <4F478A6C.2060006@ti.com>
References: <1329998490-27555-1-git-send-email-rnayak@ti.com>	<1329998490-27555-2-git-send-email-rnayak@ti.com>
	<CANrkHUarg5ntUW=S7k20LXuYe+ZNCN-cYJhfvvLKM=X8+Db4fg@mail.gmail.com>
	<4F4775FF.2090500@ti.com> <4F4787C3.1010507@ti.com>
	<4F478963.20009@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <4F478963.20009-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, "T Krishnamoorthy,
	Balaji" <balajitk-l0cyMroinI0@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On 2/24/2012 1:58 PM, Rajendra Nayak wrote:
> On Friday 24 February 2012 06:21 PM, Cousson, Benoit wrote:
>> On 2/24/2012 12:35 PM, Rajendra Nayak wrote:
>>> On Friday 24 February 2012 05:02 PM, T Krishnamoorthy, Balaji wrote:
>>>> On Thu, Feb 23, 2012 at 5:31 PM, Rajendra Nayak<rnayak-l0cyMroinI0@public.gmane.org> wrote:
...
>>>>> +Required properties:
>>>>> +- compatible:
>>>>> + Should be "ti,omap2-hsmmc", for OMAP2/3 controllers
>>>>
>>>> omap_hsmmc is applicable for omap2430 and omap3.
>>>> omap2420 has non high speed controller mmci-omap -
>>>> drivers/mmc/host/omap.c
>>>> May be omap3-hsmmc compatible with omap2430 ?
>>>
>>> Agree. I think its best in that case for me to define a
>>> compatible "ti,omap2430-hsmmc" for omap2430 and "ti,omap3-hsmmc"
>>> for omap3. Though the IP blocks are same, I cant think of some
>>> common compatible string without causing confusion.
>>
>> It depends, can we detect that using HW revision?
>
> We don't need to. The driver does not do anything different for
> 2430 or omap3.

I was thinking of OMAP2420 vs OMAP2430. But I'm now wondering if we are 
using the same driver for the non-HS controller?

>> In that case, there is no need to differentiate again with compatible.
>
> Thats perfectly fine. But what *common* compatible string would you
> use?

I think that "ti,omap2-hsmmc" is still fine, because OMAP2420 will have 
"ti,omap2-mmc" and thus we can differentiate the 2 versions.

Does that make sense?

Regards,
Benoit

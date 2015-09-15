From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v2 1/2] mmc: sdhci-of-arasan: add phy support for
 sdhci-of-arasan
Date: Tue, 15 Sep 2015 09:07:44 +0800
Message-ID: <55F76F60.7060506@rock-chips.com>
References: <1442212161-23234-1-git-send-email-shawn.lin@rock-chips.com>
 <20150914150751.GI19678@xsjsorenbubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.133]:34817 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752069AbbIOBH5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Sep 2015 21:07:57 -0400
In-Reply-To: <20150914150751.GI19678@xsjsorenbubuntu>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?UTF-8?Q?S=c3=b6ren_Brinkmann?= <soren.brinkmann@xilinx.com>
Cc: shawn.lin@rock-chips.com, Michal Simek <michal.simek@xilinx.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org

On 2015/9/14 23:07, S=C3=B6ren Brinkmann wrote:
> Hi Shawn,
>
> overall, it looks good to me. I have some questions though.
>
> On Mon, 2015-09-14 at 02:29PM +0800, Shawn Lin wrote:

[...]

>> +err_phy_exit:
>> +	phy_init(phy);
>
> Just to confirm, are these actions in the error path correct? E.g.
> if the power_off() call fails, is it safe to call power_on()? Isn't
> the phy still powered on? (this would apply to other error paths too)
>

Cool question!

While writing this, I had read generic phy stuffs deliberately to find =
a=20
solution for a case: how to deal with ping-pong fails? In another word,=
=20
if power_off call fails, then we should call power_on, but unfortunatel=
y=20
it fails again then we call power_off... so endless nested err=20
handling... No answer yet.

So, I assumed two cases happened when power_off call fails:
(1) *real power_off* is done, but some other stuffs in the calling path=
=20
fail, so phy is really power_off in theory. We need to power_on it=20
again, but if it fail, we don't know PHY is on or off since we don't=20
know power_on fails for what? *real power on* ? some other stuffs?

(2) *real power_off* isn't completed, so indeed it's *still* in power_o=
n=20
state. The reason we never need to check the return value of power_on=20
cross the err handling is that whether power_on call successfully or=20
not, it's always make phy in power_on state.

Now, let's think about case(1).
After reading dozens of sample codes(such as USB, UFS, MBUS) that adopt=
=20
generic phy framework for PHY management, real thing should be like=20
that: they NEVER deal with case(1).

It's a trick of sub-phy drivers themself. power_on/off calling path=20
return err for two case:
<1>  phy_runtime callback fails. It's after *real power on/off*, so
definitely *real power on/off* is conpleted. That is the case(2) I=20
mentioned above.
<2>  sub-phy drivers return err for  phy->ops->power_off(phy); Look
into all the sub-phy drivers twice, we find that they always return=20
success for phy->ops->power_off hook. Why? Because all of them
write registers to enable/disable something, always consider things=20
going well. Actually if we write value into a register, we have to thin=
k=20
that it's functional.

Anyway, back to this patch.
Indeed we also write value into arasan phy's register to do=20
phy_power_on/off/init/exit to make things work. Right, we return succes=
s=20
state for all of these them just as all the other sub-phy drivers do.

=46eel free to let me know if I make mistakes or misunderstanding above=
=2E

>> +	return ret;
>> +}

[...]

>> +		}
>> +	}
>
> I assume you looked at options for having the error paths in a
> consolidated location? I guess this may be the nicest solution since =
all
> of this is in this conditional block?
>

yep, otherwise we should add some *if* statements to check=20
sdhci_arasan->phy cross the err handles. And I intent to strictly limit
the phy stuffs under the scope of arasan,sdhci-5.1 currently.

> Feel free to add my
> Acked-by: S=C3=B6ren Brinkmann <soren.brinkmann@xilinx.com>
>

Thanks, S=C3=B6ren. :)

> 	S=C3=B6ren
>
>
>


--=20
Best Regards
Shawn Lin


From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH resend v3 0/2] mmc: Add SDIO function
 devicetree subnode parsing
Date: Fri, 2 Jan 2015 16:52:06 +0100
Message-ID: <CAPDyKFrTcJw0aZ-V399jJzCmi-6nqduUFV02s-bN-oDAOwVA5Q@mail.gmail.com>
References: <1404119245-5839-1-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBDF57NG2XIHRBJ75TKSQKGQE4SSPKPQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1404119245-5839-1-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Arend van Spriel <arend-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Eliad Peller <eliad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 30 June 2014 at 11:07, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> Hi All,
>
> Here is a resend of 3 of my submission of Sascha Hauer's
> "mmc: Add SDIO function devicetree subnode parsing" patch.
>
> Can we please get some movement on these patches, either a review specifying
> why this cannot go upstream, or else queuing it up for next / 3.17 ?
>
> Changes since v1:
> - Submit as a stand-alone patch-set, rather then as part of a larger oob irq
>   support patchset crossing multiple subsystems
> - Add a patch to document the already existing practice of using slot subnodes
> - Split of the dt bindings documentation for sdio-func child nodes into its
>   own patch
> - Add a preparation patch, setting slot_no where relevant
> - And finally the "Add SDIO function devicetree subnode parsing" patch itself
>   has been modified to look for the sdio function childnodes under a slot node
>   instead of directly under the host node
>
> Changes since v2:
> - Drop the slot subnodes again, and drop the 2 slot subnodes patches
>
> Regards,
>
> Hans

So after quite a delay (sorry about that!!), I decided to apply this
patchset for my next branch.

Only a minor trivial conflict showed up on patch2. Also I took the
liberty to change the prefix of patch 1 into only "mmc".

Kind regards
Uffe

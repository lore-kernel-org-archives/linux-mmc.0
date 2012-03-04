From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/3] MMC / PM: Make it possible to use PM QoS latency constraints
Date: Sun, 4 Mar 2012 11:59:21 +0100
Message-ID: <CACRpkdb-1vh6VmK95AsFuLT-3CG-gdXO-NixPiiHm8o5AtgPCQ@mail.gmail.com>
References: <201203040101.53177.rjw@sisk.pl>
	<201203040102.39253.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:53048 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752515Ab2CDK7W convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 4 Mar 2012 05:59:22 -0500
Received: by iagz16 with SMTP id z16so4277169iag.19
        for <linux-mmc@vger.kernel.org>; Sun, 04 Mar 2012 02:59:21 -0800 (PST)
In-Reply-To: <201203040102.39253.rjw@sisk.pl>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Chris Ball <cjb@laptop.org>, Ulf Hansson <ulf.hansson@stericsson.com>, Magnus Damm <magnus.damm@gmail.com>

On Sun, Mar 4, 2012 at 1:02 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:

> A runtime suspend of an MMC controller belonging to a power domain
> or, in a more complicated scenario, a runtime suspend of another
> device in the same power domain, may cause power to be removed from
> the entire domain. =A0In that case, the amount of time necessary to
> runtime-resume the MMC controller is often substantially greater
> than the time needed to enable its clock. =A0That may hurt performanc=
e
> in some situations, because user data may need to wait for the
> controller to become operational, so we should make it possible to
> prevent that from happening.
>
> For this reason, introduce a new sysfs attribute for MMC hosts,
> pm_latency_limit_ms, allowing user space to specify the upper bound
> of the time necessary to bring the host up after it has been
> runtime-suspended. =A0However, make it appear ony for the hosts whose
> drivers declare support for PM QoS by populating the pm_qos_req
> member of struct mmc_host before registering the host.
>
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Overall I've already ACKed this I think, looking good...
Acked-by: Linus Walleij <linus.walleij@linaro.org>

> @@ -191,6 +192,10 @@ struct mmc_host {
> =A0 =A0 =A0 =A0u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ocr_avail_=
mmc; =A0/* MMC-specific OCR */
> =A0 =A0 =A0 =A0struct notifier_block =A0 pm_notify;
>
> + =A0 =A0 =A0 struct dev_pm_qos_request =A0 =A0 =A0 *pm_qos_req;
> + =A0 =A0 =A0 s32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 pm_qos_val;
> + =A0 =A0 =A0 struct device_attribute =A0 =A0 =A0 =A0 pm_qos_val_attr=
;
> +
> =A0#define MMC_VDD_165_195 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x00000080 =
=A0 =A0 =A0/* VDD voltage 1.65 - 1.95 */
> =A0#define MMC_VDD_20_21 =A0 =A0 =A0 =A0 =A00x00000100 =A0 =A0 =A0/* =
VDD voltage 2.0 ~ 2.1 */
> =A0#define MMC_VDD_21_22 =A0 =A0 =A0 =A0 =A00x00000200 =A0 =A0 =A0/* =
VDD voltage 2.1 ~ 2.2 */

As you can see from the members around there we try to document
the members whenever the meaning is non-trivial.

So pm_qos_val could need
/* QoS maximum power-on delay in ms */

(The entire struct host should of course be converted to use kerneldoc
but right now the pattern is like that.)

> Index: linux/Documentation/mmc/mmc-dev-attrs.txt

Well documented!

Yours,
Linus Walleij

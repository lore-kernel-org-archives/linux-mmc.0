From: Will Newton <will.newton@gmail.com>
Subject: Re: [PATCH 2/7] mmc: dw_mmc: add quirk to indicate missing write
 protect line
Date: Wed, 2 May 2012 10:10:25 +0100
Message-ID: <CAFbHwiTRzGJgxxMAkqDDM-fPxgGe1bC3yKWCM+bNp3-i7WWcZw@mail.gmail.com>
References: <1335935266-25289-1-git-send-email-thomas.abraham@linaro.org>
	<1335935266-25289-3-git-send-email-thomas.abraham@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:34784 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756087Ab2EBJKZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 2 May 2012 05:10:25 -0400
In-Reply-To: <1335935266-25289-3-git-send-email-thomas.abraham@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Thomas Abraham <thomas.abraham@linaro.org>
Cc: linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, cjb@laptop.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, patches@linaro.org

On Wed, May 2, 2012 at 6:07 AM, Thomas Abraham
<thomas.abraham@linaro.org> wrote:
> If the write protect pad of the controller is not connected to the wr=
ite
> protect pin of the slot, the driver should be notified of this condit=
ion
> so that incorrect check for write protection by reading the WRTORT
> register can avoided. The get_ro platform callback can be used for in
> such cases, but with device tree support enabled, such platform callb=
acks
> cannot be supported.
>
> Add a new quirk for notifying the driver about the missing write prot=
ect
> line so the driver can assume that the card write protection is disab=
led.
>
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> ---
> =A0drivers/mmc/host/dw_mmc.c =A0| =A0 =A04 +++-
> =A0include/linux/mmc/dw_mmc.h | =A0 =A03 ++-
> =A02 files changed, 5 insertions(+), 2 deletions(-)

Acked-by: Will Newton <will.newton@imgtec.com>

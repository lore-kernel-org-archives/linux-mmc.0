From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2 0/4] mmc: Add SDIO function devicetree
 subnode parsing
Date: Sat, 31 May 2014 21:03:30 +0200
Message-ID: <1401563014-13856-1-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDRZXY4CYYORBEOPVCOAKGQEBRMP4AI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Arend van Spriel <arend-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Hi All,

Here is v2 of my submission of Sascha Hauer's
"mmc: Add SDIO function devicetree subnode parsing" patch.

This version has been reworked as a result of the discussion about sdio
powerup sequencing. Specifically the location of the per sdio-function subnodes
has been moved from being a subnode under the mmc host, to being a subnode
under the mmc-slot node (which itself is a subnode under the mmc host).

This not only matches the notion of their needing to be a slot abstraction
between the 2 which came up during the powerup discussion, it actually matches
what we are already doing, as while working on this patch-set I learned that
several dt-bindings already use slot child-nodes.

Note this patch-set is not about powerup sequencing, it is related though,
it is about the need to store extra info on sdio devices in devicetree in
general. The specific itch I'm scratching here is getting oob interrupts to
work for sdio wifi modules (which in my case do not need any special powerup).

Changes since v1:
- Submit as a stand-alone patch-set, rather then as part of a larger oob irq
  support patchset crossing multiple subsystems
- Add a patch to document the already existing practice of using slot subnodes
- Split of the dt bindings documentation for sdio-func child nodes into its
  own patch
- Add a preparation patch, setting slot_no where relevant
- And finally the "Add SDIO function devicetree subnode parsing" patch itself
  has been modified to look for the sdio function childnodes under a slot node
  instead of directly under the host node

Regards,

Hans

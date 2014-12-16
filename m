From: David =?utf-8?q?Lanzend=C3=B6rfer?= <david.lanzendoerfer@o2s.ch>
Subject: [PATCH 0/4] mmc: sunxi: General fixup
Date: Tue, 16 Dec 2014 01:37:40 +0100
Message-ID: <20141216003412.15488.54812.stgit@dizzy-6.o2s.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Arnd Bergmann <arnd@arndb.de>, linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>, linux-kernel@vger.kernel.org, Peter Griffin <peter.griffin@linaro.org>, Hans de Goede <hdegoede@redhat.com>, Chen-Yu Tsai <wens@csie.org>, David =?utf-8?q?Lanzend=C3=B6rfer?= <david.lanzendoerfer@o2s.ch>, =?utf-8?b?5p2O5oOz?= <lixiang@allwinnertech.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Hello
This patchset was inspired questions from =E6=9D=8E=E6=83=B3 of Allwinn=
er and incorporates as
well suggestions from Hans related to spin locks.
=46or example have not all attributes of the shared host object been pr=
otected
by the spin lock, this has been changed.
Also some register names and reset behavior have been fixed now.
And a minor cleanup happened at the clock frequecy setting, since there=
 has
been a piece of left over code which has been there because it was in t=
he Android
driver and we just adapted it because we didn't have proper documentati=
on about
the timing of the module.

Looking forward to your feedback
Cheers David

---

David Lanzend=C3=B6rfer (4):
      mmc: sunxi: Lock fix
      mmc: sunxi: Correcting SDXC_HARDWARE_RESET bit
      mmc: sunxi: Reset behavior fix
      mmc: sunxi: Removing unused code


 drivers/mmc/host/sunxi-mmc.c |   37 +++++++++++++++++++++++++---------=
---
 1 file changed, 25 insertions(+), 12 deletions(-)

--
Signature

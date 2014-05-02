From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v10 01/15] clk: sunxi: factors: automatic
 reparenting support
Date: Fri,  2 May 2014 17:57:15 +0200
Message-ID: <1399046249-19472-2-git-send-email-hdegoede@redhat.com>
References: <1399046249-19472-1-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBDRZXY4CYYORB5UAR6NQKGQENA2OF2A-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1399046249-19472-1-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: =?UTF-8?q?David=20Lanzend=C3=B6rfer?= <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

From: Emilio L=C3=B3pez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>

This commit implements .determine_rate, so that our factor clocks can be
reparented when needed.

Signed-off-by: Emilio L=C3=B3pez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>
Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Acked-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 drivers/clk/sunxi/clk-factors.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/clk/sunxi/clk-factors.c b/drivers/clk/sunxi/clk-factor=
s.c
index 9e23264..3806d97 100644
--- a/drivers/clk/sunxi/clk-factors.c
+++ b/drivers/clk/sunxi/clk-factors.c
@@ -77,6 +77,41 @@ static long clk_factors_round_rate(struct clk_hw *hw, un=
signed long rate,
 	return rate;
 }
=20
+static long clk_factors_determine_rate(struct clk_hw *hw, unsigned long ra=
te,
+				       unsigned long *best_parent_rate,
+				       struct clk **best_parent_p)
+{
+	struct clk *clk =3D hw->clk, *parent, *best_parent =3D NULL;
+	int i, num_parents;
+	unsigned long parent_rate, best =3D 0, child_rate, best_child_rate =3D 0;
+
+	/* find the parent that can help provide the fastest rate <=3D rate */
+	num_parents =3D __clk_get_num_parents(clk);
+	for (i =3D 0; i < num_parents; i++) {
+		parent =3D clk_get_parent_by_index(clk, i);
+		if (!parent)
+			continue;
+		if (__clk_get_flags(clk) & CLK_SET_RATE_PARENT)
+			parent_rate =3D __clk_round_rate(parent, rate);
+		else
+			parent_rate =3D __clk_get_rate(parent);
+
+		child_rate =3D clk_factors_round_rate(hw, rate, &parent_rate);
+
+		if (child_rate <=3D rate && child_rate > best_child_rate) {
+			best_parent =3D parent;
+			best =3D parent_rate;
+			best_child_rate =3D child_rate;
+		}
+	}
+
+	if (best_parent)
+		*best_parent_p =3D best_parent;
+	*best_parent_rate =3D best;
+
+	return best_child_rate;
+}
+
 static int clk_factors_set_rate(struct clk_hw *hw, unsigned long rate,
 				unsigned long parent_rate)
 {
@@ -113,6 +148,7 @@ static int clk_factors_set_rate(struct clk_hw *hw, unsi=
gned long rate,
 }
=20
 const struct clk_ops clk_factors_ops =3D {
+	.determine_rate =3D clk_factors_determine_rate,
 	.recalc_rate =3D clk_factors_recalc_rate,
 	.round_rate =3D clk_factors_round_rate,
 	.set_rate =3D clk_factors_set_rate,
--=20
1.9.0

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.

From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/9] Enable dw-mmc multi-card support
Date: Wed, 25 Oct 2017 18:50:08 +0200
Message-ID: <CAPDyKFrjWiQAVTFxWLvmY4Vdom5UNZ5T2Jvw+jdwKi8soudy9A@mail.gmail.com>
References: <cover.1507315433.git.lsun@mellanox.com> <8e433531-8f67-d575-635e-c6ced29f6804@rock-chips.com>
 <CGME20171017155217epcas3p4de2f27b921ce77234a2d3e46e4b17473@epcas3p4.samsung.com>
 <AM2PR05MB07533A822C7CCBA7111FD58FA14C0@AM2PR05MB0753.eurprd05.prod.outlook.com>
 <f71d94dc-7277-8675-c21e-9c2ec77174e7@samsung.com> <AM2PR05MB07537D50A18D391CD2295D84A1430@AM2PR05MB0753.eurprd05.prod.outlook.com>
 <CAPDyKFo9jt6V01WWGEXuB7QFz6_-Gqiuzcujh3R-VO2A052DTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFo9jt6V01WWGEXuB7QFz6_-Gqiuzcujh3R-VO2A052DTA@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Liming Sun <lsun@mellanox.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Shawn Lin <shawn.lin@rock-chips.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Chris Metcalf <cmetcalf@mellanox.com>
List-Id: linux-mmc@vger.kernel.org

[...]

> Unfortunate patch 8 and 9 does *not* solve the fundamental problem
> with multiple slots. You can't solve it without involving the mmc
> core, as explained in earlier discussions [1].
>

This link got lost, so here it is:

[1]
https://www.spinics.net/lists/linux-mmc/msg46549.html

[...]

Kind regards
Uffe

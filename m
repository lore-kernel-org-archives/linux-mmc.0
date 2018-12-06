From: Ludovic Barre <ludovic.Barre@st.com>
Subject: [PATCH V3 0/2] mmc: mmci: add stop command
Date: Thu, 6 Dec 2018 16:13:30 +0100
Message-ID: <1544109212-12621-1-git-send-email-ludovic.Barre@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org, Alexandre Torgue <alexandre.torgue@st.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, srinivas.kandagatla@linaro.org, Ludovic Barre <ludovic.barre@st.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch series adds variant property to:
-Set cmdstop bit on STOP_TRANSMISSION command.
-On command or data error, send a stop command.
to clear DPSM if it's yet activated.

change v3:
-Move the cmdstop bit in separate patch.
-Use Ulf re-wording for patch 2/2.
-Move specific part in a separate function.

Ludovic Barre (2):
  mmc: mmci: add variant property to set command stop bit
  mmc: mmci: send stop command to clear the dpsm

 drivers/mmc/host/mmci.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/mmci.h |  4 ++++
 2 files changed, 47 insertions(+)

-- 
2.7.4

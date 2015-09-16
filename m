From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 2/2] mmc: vub300: Remove unneded semicolons
Date: Wed, 16 Sep 2015 11:30:04 +0200
Message-ID: <1442395804-17736-2-git-send-email-javier@osg.samsung.com>
References: <1442395804-17736-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1442395804-17736-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Tony Olech <tony.olech@elandigitalsystems.com>, linux-usb@vger.kernel.org, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

They aren't needed and are just creating null statements so remove it.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

 drivers/mmc/host/vub300.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
index fbabbb82b354..1e819f98b94f 100644
--- a/drivers/mmc/host/vub300.c
+++ b/drivers/mmc/host/vub300.c
@@ -563,7 +563,7 @@ static void add_offloaded_reg(struct vub300_mmc_host *vub300,
 			i += 1;
 			continue;
 		}
-	};
+	}
 	__add_offloaded_reg_to_fifo(vub300, register_access, func);
 }
 
@@ -1372,7 +1372,7 @@ static void download_offload_pseudocode(struct vub300_mmc_host *vub300)
 		l += snprintf(vub300->vub_name + l,
 			      sizeof(vub300->vub_name) - l, "_%04X%04X",
 			      sf->vendor, sf->device);
-	};
+	}
 	snprintf(vub300->vub_name + l, sizeof(vub300->vub_name) - l, ".bin");
 	dev_info(&vub300->udev->dev, "requesting offload firmware %s\n",
 		 vub300->vub_name);
@@ -1893,7 +1893,7 @@ static int satisfy_request_from_offloaded_data(struct vub300_mmc_host *vub300,
 			i += 1;
 			continue;
 		}
-	};
+	}
 	if (vub300->total_offload_count == 0)
 		return 0;
 	else if (vub300->fn[func].offload_count == 0)
-- 
2.4.3
